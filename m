Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B0201278
	for <linux-mmc@vger.kernel.org>; Mon, 14 Jul 2025 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752475695; cv=none; b=OXl40T3mh5qD205XfGH90Z+9s0zlTmLp+sE1DGukVIzrWWQ4XVXY5GdjEt0Xl+rYAGh0y0wnekhp9ZQA79l5TUHZTS8bw3e8xJEXlqqkhxL6qTbr03pQXXSw87NKARaR66kwKxGGKuTZVJuMwk8zVmgo2PsxdCjvpogcOozF08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752475695; c=relaxed/simple;
	bh=ri4phK8K0KTwvLvMiQWhknNRdht5zLBNG8RrCC1LcLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUO0WyMy2CM5fOcHWhzfWxGOatjkRIc2kJ7Lm9b68STPucDFXep76udS82hjtfIelP6Nqzb/qbGCc3wzUfFs77W8TrhqEwpqKa/8FpWo2avntTr6L+9qDb8BIUs/dtCA9M68SM3ldG2bXAvQ/oAjDWfsl0XjSqGYNxPp4yDI3X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqDOr1Y2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqDOr1Y2"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a54700a463so2147302f8f.1
        for <linux-mmc@vger.kernel.org>; Sun, 13 Jul 2025 23:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752475692; x=1753080492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh+mK2IgRHnEV6ffgQ7q41nHkn8xL5pNUHK9x2icOZg=;
        b=CqDOr1Y2jYI1EYStR6HkhsM1OnHIp7zE5M/+vxVv39Cc6ycqxjHBhmLifV7tuF/T4A
         mNRguZWdIeSZu27KTd7qPFqADjvKtMWeeLtvNgG1/h3gc3J8IBxVk/RlpcdODtPgzCre
         NYJxudI+82oPAjklHAqgChc2eoHEB0G2uP8Apv7okVyU5kIpwMR2P9f88wovcu8ZCH0Z
         vmydmwrrN5QtFDKwQQ1p4dG76g70OqSyDvv7aLOO1a7kTswhlHwANS817Z54+xwR6f3n
         Kcb0DtK+T7r1d3M/OOqevi3GT1eg2zRBRGQ3XlBAE5l7ADpypImreO3BGONi62eoCTA6
         YUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752475692; x=1753080492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jh+mK2IgRHnEV6ffgQ7q41nHkn8xL5pNUHK9x2icOZg=;
        b=J25oGdHbliPa2YQj3h+wDUs1n0OMzmydtSDrm7R/Ma/TEFzLduLvoCc+5EcFJ2BMMX
         fX/y79D5KTYQor0xuY2KFieJ1TxDg2ryz1+EZH5KH88Rda1QSl+Du9V3aXbUQZE9wzBk
         80nQZiIzggmw12thJFu2/3jSMCY/Zg1BwoqPgtuqI771Lg/PT2sxKxKWu8+yL4MsgF6J
         KYLyTNDZXXo5xq2B7Gt5venXURnOLoCBGEm4QjxCqV0go7s50R1J5DA/u3TNX4kc2ihW
         o2WFoCrDpJVxz8HOilWT+k/9iTt7I8pDwrRVgKLow2wCsTkv2vu6ncWuwhbSYbvngWru
         F+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWs+e1iox8cv9ZKkuPcQ8XHYR0gvn3q1DWAfPPYLWbFwddvQAYx9ZYpbbsZOEOHVLxIsS5cg3oDcjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+DnIjxIzKm+4FACVoQtm2UGgyfULXVbfT6PGyPRZWvLLk/Yro
	RIdHbBMxSrhRfH8tX+fU9zpPF1ZqKEuPLQq+Nz1hTNKhN+cio1HvxbGr
X-Gm-Gg: ASbGnct9CczTFDAqp5GMrJG1LMJwaOiHFPIujkH0I+ySi2McYQChlyWvcIvbAXvSC1y
	c73EkZczRbIBm8IfMMRWkNNlVWIlTnweyFZkwhl3JADD9KwcjoQhea/8DVRVz2y1U1NrVfQqDNY
	dOaGlvIXhbcCIXXthkHL1ypwuKU3a5gMMWC3mgsv/gf1n9WYKpruBM5UCa+D5stn/Qo4Tmq3je4
	n20J7MdJH4I/8e5X+4nXf/pdBkkyYOyt/v2GXvy0fvKakcDsUnlb0oBf+y2QZorqP05vlKNY7yL
	Ggo/9uPZWJdnmxxb4bCyzAbSHWJzCaaXkKJSycKBbGl+uoQ+VohLKLxvGJAEOqx1rQFapEH9ONp
	Bj8MOurYVoJ7k4QNNIuhgDnpZOtHUMzgO7GjSU1JRRlbGLAlVAU0a9mcrpCkTQxxZxV1syhfUIP
	Ha/0s=
X-Google-Smtp-Source: AGHT+IGWpZ5tUZdcAOXF0bvzNqvMD166TSjTcjRuYghcRTdE5zslts64IWvQ4J2wVnYfkEmyCp3TVA==
X-Received: by 2002:a05:6000:2c09:b0:3a4:dfbe:2b14 with SMTP id ffacd0b85a97d-3b5f1e87023mr9201704f8f.16.1752475692161;
        Sun, 13 Jul 2025 23:48:12 -0700 (PDT)
Received: from mdionisio-OptiPlex-7070.powersoft.it (srvsp.powersoft.it. [93.146.228.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1e4fsm11439829f8f.21.2025.07.13.23.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:48:11 -0700 (PDT)
From: Michele Dionisio <michele.dionisio@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <Avri.Altman@sandisk.com>,
	Michele Dionisio <michele.dionisio@gmail.com>
Subject: [PATCH v2] mmc-utils: add ability to flush optional eMMC cache
Date: Mon, 14 Jul 2025 08:48:07 +0200
Message-ID: <20250714064807.1915470-1-michele.dionisio@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MMC 5.0 instroduce command to flush cache. This feature can be use on
embedded device there power is not stable.


Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
---
Changes since v1:
 - Remove redundant cover letter
 - Add docs/HOWTO.rst
 - add check to not flush if cache is disabled

 docs/HOWTO.rst |  5 +++++
 man/mmc.1      |  4 ++++
 mmc.c          |  5 +++++
 mmc.h          |  1 +
 mmc_cmds.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h     |  1 +
 6 files changed, 68 insertions(+)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index f2f2f35..d454d8c 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -107,3 +107,8 @@ Running mmc-utils
     ``mmc rpmb secure-wp-enable <rpmb device> <key file>``
         Disable updating WP related EXT_CSD and CSD fields.
         Applicable only if secure write protect mode is enabled.
+
+
+    ``mmc cache flush <device>``
+        Flush the eMMC cache for <device>.
+        Applicable only if device version >= eMMC5.0.
diff --git a/man/mmc.1 b/man/mmc.1
index bccabf3..665fe6d 100644
--- a/man/mmc.1
+++ b/man/mmc.1
@@ -109,6 +109,10 @@ NOTE! The cache is an optional feature on devices >= eMMC4.5.
 Disable the eMMC cache feature on <device>.
 NOTE! The cache is an optional feature on devices >= eMMC4.5.
 .TP
+.BR "cache flush <device>"
+Flush the eMMC cache on <device>.
+NOTE! The cache is an optional feature on devices >= eMMC5.0.
+.TP
 .BR "<cmd> --help"
 Show detailed help for a command or subset of commands.
 
diff --git a/mmc.c b/mmc.c
index 6770a45..fce7eef 100644
--- a/mmc.c
+++ b/mmc.c
@@ -231,6 +231,11 @@ static struct Command commands[] = {
 		"Disable the eMMC cache feature on <device>.\n"
 		"NOTE! The cache is an optional feature on devices >= eMMC4.5.",
 	},
+	{ do_cache_flush, 1,
+	  "cache flush", "<device>\n"
+		"flush the eMMC cache <device>.\n"
+		"NOTE! The cache is an optional feature on devices >= eMMC5.0.",
+	},
 	{ do_read_csd, -1,
 	  "csd read", "<device path>\n"
 		  "Print CSD data from <device path>.\n"
diff --git a/mmc.h b/mmc.h
index 9fc22ec..2bb346b 100644
--- a/mmc.h
+++ b/mmc.h
@@ -152,6 +152,7 @@
 #define EXT_CSD_DATA_SECTOR_SIZE	61 /* R */
 #define EXT_CSD_EXT_PARTITIONS_ATTRIBUTE_1	53
 #define EXT_CSD_EXT_PARTITIONS_ATTRIBUTE_0	52
+#define EXT_CSD_FLUSH_CACHE     32
 #define EXT_CSD_CACHE_CTRL		33
 #define EXT_CSD_MODE_CONFIG		30
 #define EXT_CSD_MODE_OPERATION_CODES	29	/* W */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index d56a3ed..16c6b2e 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2865,6 +2865,58 @@ int do_cache_dis(int nargs, char **argv)
 	return do_cache_ctrl(0, nargs, argv);
 }
 
+int do_cache_flush(int nargs, char **argv)
+{
+	__u8 ext_csd[512];
+	int fd, ret;
+	char *device;
+
+	device = argv[1];
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	ret = read_extcsd(fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		exit(1);
+	}
+
+	if (ext_csd[EXT_CSD_REV] < EXT_CSD_REV_V5_0) {
+		fprintf(stderr,
+			"The CACHE FLUSH option is only availabe on devices >= "
+			"MMC 5.0 %s\n", device);
+		exit(1);
+	}
+
+	/* If the cache size is zero, this device does not have a cache */
+	if (!(ext_csd[EXT_CSD_CACHE_SIZE_3] ||
+			ext_csd[EXT_CSD_CACHE_SIZE_2] ||
+			ext_csd[EXT_CSD_CACHE_SIZE_1] ||
+			ext_csd[EXT_CSD_CACHE_SIZE_0])) {
+		fprintf(stderr,
+			"The CACHE option is not available on %s\n",
+			device);
+		exit(1);
+	}
+
+	if (ext_csd[EXT_CSD_CACHE_CTRL]) {
+		ret = write_extcsd_value(fd, EXT_CSD_FLUSH_CACHE, 1, 0);
+		if (ret) {
+			fprintf(stderr,
+				"Could not write 0x%02x to EXT_CSD[%d] in %s\n",
+				EXT_CSD_FLUSH_CACHE, EXT_CSD_FLUSH_CACHE, device);
+			exit(1);
+		}
+	}
+
+	close(fd);
+	return 0;
+}
+
 static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
 {
 	int ret = 0;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index ce35d3e..f767deb 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -50,6 +50,7 @@ int do_rpmb_sec_wp_mode_clear(int nargs, char **argv);
 int do_rpmb_sec_wp_en_read(int nargs, char **argv);
 int do_cache_en(int nargs, char **argv);
 int do_cache_dis(int nargs, char **argv);
+int do_cache_flush(int nargs, char **argv);
 int do_ffu(int nargs, char **argv);
 int do_opt_ffu1(int nargs, char **argv);
 int do_opt_ffu2(int nargs, char **argv);
-- 
2.43.0

