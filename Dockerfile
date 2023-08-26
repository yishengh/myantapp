# 使用 Node.js 18 作为基础镜像
FROM node:18 AS builder

# 设置工作目录
WORKDIR /app

# 复制项目文件到工作目录
COPY package.json package-lock.json ./
COPY . ./

# 安装依赖
RUN npm install

# 构建项目
RUN npm run build

# 使用 Nginx 作为基础镜像
FROM nginx:alpine

# 复制构建后的文件到 Nginx 的默认网站目录
COPY --from=builder /app/dist /usr/share/nginx/html

# 配置 Nginx，如果需要的话
# COPY nginx.conf /etc/nginx/nginx.conf

# 暴露端口
EXPOSE 8000

# 启动 Nginx 服务
CMD ["nginx", "-g", "daemon off;"]
