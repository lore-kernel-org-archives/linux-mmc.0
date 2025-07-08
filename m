Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CA029826D
	for <linux-mmc@vger.kernel.org>; Tue,  8 Jul 2025 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962895; cv=none; b=LNo/f+hfbYitC7KDjr511wpv42cj+5e+ftQWe8QOgf+fcq5DelERcpTPLPKj+BclaUl6Fz/i23QIf42Ky0cVN8VTc9yXV20woZA/AVvvmhPu/X5jQ0PcRBSw3+ZaYCNBJXPe0FIQLZH9L8h2Z/lL840CoLIsuOAOdpWxkU7Bg/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962895; c=relaxed/simple;
	bh=hdosg4A9scDagyNYuIXsvAHsCP6YBBcuzOSABpntBR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTP++zV8bv71+E5lowaUhNyoFAMwS2OHsW6y/302zq7F9M7W9AR787dfzKg8XOKjQ7ZYmUgXWK3NDPYEqSYlHTXUQOAKwWa9OJIlokWgULi9H/vGlS0St0/g3552bsIF99xVDkxRn+nChXX88E6Sx6H6HfJxPt6cxmKxRGg96lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5jsOGAp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5jsOGAp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-453647147c6so38097845e9.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jul 2025 01:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751962891; x=1752567691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14RS0hkcfhnwTk1wVwFtDI37LnE1Kj37tJzTM4MfqSI=;
        b=P5jsOGAppyQXKJ7LgrMiS1Sltoh/xa3EZU9d9wTx8W/QS1JMIhCioW2W/8HK5XLCZ3
         znY7b+yLB1u6pUUoRXA1InDyTUfYYntzXWJzCmuzhdQixu1KbywOpRvQ7pBnqA6qfWZS
         T/DuUE9bn4IMSDeou/h03t9i68acNOkCiJrqcMohjzEQLRccA5DiRrGVzINlXMc2OCjB
         uyGFRAzvzx8jn6aR3weLLrMjyRNFAOgCCUIJSRKmU2Vg6y0Bzoa5TsFxkvK9WZn3Lu2G
         fNfeRf1idLQz0avyyzW+H3X07mlS83uJKaNoZr6BT+xaoz6kszNoQWh+6wbI2xyhm9fx
         AiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751962891; x=1752567691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14RS0hkcfhnwTk1wVwFtDI37LnE1Kj37tJzTM4MfqSI=;
        b=LDjaRrTa7MCHevr7v1gRN7OHBvtrNzSKt6dILndpc2Lgrq5BfAD1Uxu4FqmzZrgdvf
         /q691QMBbNCS5fFIKQixUOxvHqGEmiHIrcxfoOeWWZ3JSjMiJdeGLpgcsk7QAui58jBp
         /j5UnleAVSlGbr3idepeh9hLPAN9ULqrQyxBI6cUba6KTt0yOst1+4P/WavE89O5fUQa
         uCDK5pQRn3tPJbiNIfVoaks4KwiNBIV+8hNaqdiYtXF7z+VE6eILB0iNbRht6YU34dG6
         CWIo30dLVJ26eDf7zVcD8qxMcwcOaBODaJPYUpx/i+eQNSUAP0b9MLnyO7BX0caj4lkq
         2dgw==
X-Gm-Message-State: AOJu0YzJV9EHt/7XOsWkyLVbCOJUGnUmp6rVfHH6aqkuzn/ITxPQviHs
	MWjz4zg+lqVNrppxm4cEI1inxOxbEsUIXf4FSycHqoWgYjSvbbqZOQGCR7asbA==
X-Gm-Gg: ASbGncs4oXSKbhls1EIKT8diHBQpB1O+7eSzg7hAcHt4XuEtkRS6T5rydtVI3KMKFVe
	/pN/g0CPcYLjdJymuLv6qCDmNr6VITibDa/iglWEsuewFE5KTGrntU9/eYPzImEIaGTQw7PHsdf
	JFAQejW2LLEukSZ5I4qJJku88CGggIKUCsihYepkXDaPq8tUy55hbKht1FAdVyUK9l3E2mQmlZo
	jJ/0qyxhOWf+k1SKNcM31mS+89/FycrcDQA5FlgMtFkBHo3BAQ2qauqwX8SDU7v2XtKEHmYYYd+
	RI0mXNukZuZ2nvzckRRIkrFs29dvX4qrKNav2E0dVwcWqdJ0pMxy5voE/qN+Hhd5iPb1/U7t3/v
	/Ba42g+5XRwYmuuKkojjswPmjs7QWbMCrvOx4jcTjlZM=
X-Google-Smtp-Source: AGHT+IHqg6E7xc0d91yJqIKMwxn0YH/AdIWEIIOCIDEliRxZ9sVsjRrXE41TP2GgIuyddtXO4yiXHQ==
X-Received: by 2002:a05:600c:5289:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-454cd4d8f27mr21185135e9.3.1751962891065;
        Tue, 08 Jul 2025 01:21:31 -0700 (PDT)
Received: from mdionisio-OptiPlex-7070.powersoft.it (srvsp.powersoft.it. [93.146.228.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd4938f4sm14296585e9.19.2025.07.08.01.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 01:21:30 -0700 (PDT)
From: Michele Dionisio <michele.dionisio@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	michele.dionisio@gmail.com,
	Michele Dionisio <michele.dionisio@powersoft.com>
Subject: [PATCH 1/1] mmc-utils: add ability to flush optional eMMC cache
Date: Tue,  8 Jul 2025 10:21:05 +0200
Message-ID: <20250708082105.160653-2-michele.dionisio@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708082105.160653-1-michele.dionisio@gmail.com>
References: <20250708082105.160653-1-michele.dionisio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michele Dionisio <michele.dionisio@powersoft.com>

The MMC 5.0 instroduce command to flush cache


Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
---
 man/mmc.1  |  4 ++++
 mmc.c      |  5 +++++
 mmc.h      |  1 +
 mmc_cmds.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  1 +
 5 files changed, 61 insertions(+)

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
index 6770a45..3c82504 100644
--- a/mmc.c
+++ b/mmc.c
@@ -231,6 +231,11 @@ static struct Command commands[] = {
 		"Disable the eMMC cache feature on <device>.\n"
 		"NOTE! The cache is an optional feature on devices >= eMMC4.5.",
 	},
+	{ do_cache_flush, -1,
+	  "cache flush", "<device>\n"
+		"flush the eMMC cache <device>.\n"
+		"NOTE! The cache is an optional feature on devices >= eMMC4.5.",
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
index b16ac69..1b26f31 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2870,6 +2870,56 @@ int do_cache_dis(int nargs, char **argv)
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
+	ret = write_extcsd_value(fd, EXT_CSD_FLUSH_CACHE, 1, 0);
+	if (ret) {
+		fprintf(stderr,
+			"Could not write 0x%02x to EXT_CSD[%d] in %s\n",
+			EXT_CSD_FLUSH_CACHE, EXT_CSD_FLUSH_CACHE, device);
+		exit(1);
+	}
+
+	close(fd);
+	return ret;
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

