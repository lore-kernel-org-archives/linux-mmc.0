Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5873524E4C4
	for <linux-mmc@vger.kernel.org>; Thu, 10 Jul 2025 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148642; cv=none; b=km9mzV1/FvPM7cAifVI0mQPxOFS43rrnrqRAY9b/m6EHYphpnmWTClPVkbR+w8yt/WTKPjxRprfQ6eK25EEmGPFh0xbRp2taoz9xkz+r9tPxRwmV+SNunT5g1hbbRSTcYvGI4uLIccvBDRV4ddoVTzmie3Uzb6sBun496oyDNA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148642; c=relaxed/simple;
	bh=am8oNNKDPx+xbCYXKkbMtTBhe4se0uMt0JG3qQiFk/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pF8j6wfUePn8Be86s67rhZpXAy2nrtunCHYVIkeWQycfAvLI/EpDSTJ2x+GoeNPt2RTZUqxJ0dyRbEvxPEBa9wlgMkPpslOasxX+eIzTlXYM1FMrp0nU4nJtR/5VnriANNYriDkAs6p08vUEFSjLrQBxowZFb6OaRygoH+MFeVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtZzSYHu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtZzSYHu"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4537deebb01so4835475e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 10 Jul 2025 04:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752148638; x=1752753438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRYWfNUM1qQAOt3GkNcMgRTTBVEpw64ARB6Pr45uhbw=;
        b=dtZzSYHuUSyNT6cCjEqMRwxZnB97HiZN0NyrtxnOqgnH5foXPWNX4Rzxe+czd1ySXq
         UkVNkiXAsndmNfWAV9otoWSS20TFFhV+3MWysCpSHTY5eisURlfCRRxx9zfv0RGF8Pfi
         TKzwXLV8i+/5RLDAb+3DTIwiX2IdHDSxxW81asK1WTuNlKMuBG6uHTumGdy/kV03sTA1
         18FcRg1rT/VgbmsAk/e0ZJZaF6APO50KGX/kbEp/YB08PLpJLxUZTv9ZBrTwyO7E2mCd
         YG/e0tx4terirPetPVLP45mr1K5pmy016+rvh9rUy8BJlCm4dKZ6T7J5hOO3hMx/HTUb
         ZiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752148638; x=1752753438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRYWfNUM1qQAOt3GkNcMgRTTBVEpw64ARB6Pr45uhbw=;
        b=WFYuRvePn4zccEpF6QnUsUhr/0yrUF4VMpAw92j0t8gNQyru8kqX7pk1seGiTQRtUk
         v+TrMv20eDegDBmoh0hG7un0tsnRYf2JnFsVV/T9MGlWcS+xiesAcDOKfD2Cct/w0qP1
         3QDFC6A42qweKNHFBP3+NeRllIUaoVVzV15d3/ezaPl1Qrh4Ga38fU2c91svbzrB2/f7
         0oa7c1C+06UPZ8FkJMl3jXMCqjq/PZnUdvA3mEiGnMsmu20+QTqEIgcvttR7brrsoyxs
         nSk2oKTnB9ON/7MGo8YJNnkViPYO9U9cIoqxKk2l07YIxSBWzdbmnyvKau8LA9alsrM2
         TFdg==
X-Gm-Message-State: AOJu0YzSz1EoQV5DrVmNKGxhwhOQ8SB4+lODQNXA1x0hBOM8emj9IS1h
	T57N3mJcXELCb+hP2jc60ZiLgJkGWihPS7BNmbq60mU3JHC/vT25/uy1fPgGgA==
X-Gm-Gg: ASbGncvD7hi3yQzEIpYNpZgZprgi6IylZDM4pKoBax1RTdCOB2q5AZEyzH1PUJbQHNJ
	wK9vBhWipnTeDuYELb9cRTCMpL0RZx+scipUXypCqjQlWSTK3OAY7mCk4CcYkqFnzYort7mW2ao
	5hHsW0MhN3sMgItiaMe5rmuH/1uAqwOULKB8ugLUoMWZLuXtq9wK9Ixeth1wbWCRQ+TPCCUBIlC
	PD6LR36H4gv/DcV8l9yztkWpNosO0B5JbugSq3zTRI+0GWejTCqXFHdgYtE8nIx3WdOF25x1t6/
	uO+ZkK3WLNhHvXk+NG2HhfmDjksI8EkkLGdt5M6nAbKXey2W7lh7Eo0GWrzXFIO/cvRfkemCrma
	hec0mGmHNLLFqtzyoR3k1i1FrcLztRhu2T/HhLMuRwe8=
X-Google-Smtp-Source: AGHT+IHWunL/++yFYClg0eKjgEgZab9xZtvL9h5CW1RMwmkab+GulFtpd+hFScFcF182CqCQErRYag==
X-Received: by 2002:a05:600c:a08c:b0:440:61eb:2ce5 with SMTP id 5b1f17b1804b1-454dd2929a0mr27808495e9.17.1752148638255;
        Thu, 10 Jul 2025 04:57:18 -0700 (PDT)
Received: from mdionisio-OptiPlex-7070.powersoft.it (srvsp.powersoft.it. [93.146.228.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e2747fsm1652622f8f.100.2025.07.10.04.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:57:17 -0700 (PDT)
From: Michele Dionisio <michele.dionisio@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	Michele Dionisio <michele.dionisio@powersoft.com>,
	Michele Dionisio <michele.dionisio@gmail.com>
Subject: [PATCH 3/3] mmc-utils: add ability to flush optional eMMC cache
Date: Thu, 10 Jul 2025 13:56:34 +0200
Message-ID: <20250710115653.2808619-4-michele.dionisio@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710115653.2808619-1-michele.dionisio@gmail.com>
References: <PH7PR16MB6196D50A37E3A318ED6B98BEE54EA@PH7PR16MB6196.namprd16.prod.outlook.com>
 <20250710115653.2808619-1-michele.dionisio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michele Dionisio <michele.dionisio@powersoft.com>

The MMC 5.0 instroduce command to flush cache. This feature can be use on
embedded device there power is not stable.


Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
---
 docs/HOWTO.rst |  4 ++++
 man/mmc.1      |  4 ++++
 mmc.c          |  5 ++++
 mmc.h          |  1 +
 mmc_cmds.c     | 64 +++++++++++++++++++++++++++++++++++++++++++++-----
 mmc_cmds.h     |  1 +
 6 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index 9b1f1a8..ab2e255 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -117,3 +117,7 @@ Running mmc-utils
     ``mmc cache disable <device>``
         Disable the eMMC cache feature on <device>.
         Applicable only if device version >= eMMC4.5.
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
index 7433755..bd9d498 100644
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
index b16ac69..eb9924e 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2838,12 +2838,14 @@ static int do_cache_ctrl(int value, int nargs, char **argv)
 			device);
 		exit(1);
 	}
-	ret = write_extcsd_value(fd, EXT_CSD_CACHE_CTRL, value, 0);
-	if (ret) {
-		fprintf(stderr,
-			"Could not write 0x%02x to EXT_CSD[%d] in %s\n",
-			value, EXT_CSD_CACHE_CTRL, device);
-		exit(1);
+	if (ext_csd[EXT_CSD_CACHE_CTRL]) {
+		ret = write_extcsd_value(fd, EXT_CSD_CACHE_CTRL, value, 0);
+		if (ret) {
+			fprintf(stderr,
+				"Could not write 0x%02x to EXT_CSD[%d] in %s\n",
+				value, EXT_CSD_CACHE_CTRL, device);
+			exit(1);
+		}
 	}
 
 	close(fd);
@@ -2870,6 +2872,56 @@ int do_cache_dis(int nargs, char **argv)
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

