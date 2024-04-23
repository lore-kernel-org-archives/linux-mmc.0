Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBDB14198A
	for <linux-mmc@vger.kernel.org>; Tue, 23 Apr 2024 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902565; cv=none; b=M4fLKOzzAYCZoLUwKcheBGy11IO1coVYL/rHvQIWyvcg1Sc3EEmDIx/HdJk1XEFTXBvZpawChglekYyra3qX+hU7EizntytkwGYug0Kp9Z7GTbiXXvrW04cwN48KnZqK8okf+WEFP4YukP8OTNY8yEO2Ulsgisik+ZLgOrOrbe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902565; c=relaxed/simple;
	bh=1jdZkbQhC4/v9Esi0hWpLiKGXFdBsI04OMiMG3Mz+Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type; b=TdzXVCPFE0S+VE4X+aFgQjI5QBS5u/T9QFAdrGQSGzZ38a29GO0aMvcDQt7+u5FJ6K3kkb61X9N2h5O8XdQZadBydbnkxdp08CWi/kYFtoMIcC4Hl/Dxx5LrvYTh9hSHvhuQgLtLvDOjyhPenVHklhC4zpljREMjMz/w7eR2ROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gzp/UIL4; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gzp/UIL4"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbbc6e51d0so3077372b6e.3
        for <linux-mmc@vger.kernel.org>; Tue, 23 Apr 2024 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713902563; x=1714507363; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07pU25ESlRlyhlNH3OzHCKX+S+tOmmXyQhNzps/XQcY=;
        b=gzp/UIL4DBb08k8HXWtAm/49gQG9QwaVsC6YmofyvnEu/aGx9HVD+R4IFReLID9Vxz
         3xc8oV3Yz919l0Bwheyf7JjFWNKcXgevnunGG+7JMhs/zrE5qw0oIV3DR/K7x9yvivgg
         MWb8Qn+5axjqifURqNoH64c4MG/DHai1Xi8iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713902563; x=1714507363;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07pU25ESlRlyhlNH3OzHCKX+S+tOmmXyQhNzps/XQcY=;
        b=XIofA+ncA1ccuiAsVqH7umNsMtidie7KguN5whM6izvPGTX4ZwWS3jDyiqOuwDbfLs
         9x2x2rd5YR3jKifg7sT0aQPvGatlfwFsYCN4hmQA5wQMlf45q5+oE9ak4xp3cezL1K+9
         u2KtEDihwxD+xa2yKBqe6iEID3aE5vDMS5Y+p54nk1TqcVFi7ltpV5qy+eXZIUiaRy4i
         hSstXz4iQErWqFEfK+b0OuSCCkPND1Z5Q1xxigFikwoG4KmKcMKEYI+lokGdR+Fd0XHY
         rEIHGf2DRcuvmHL2aq/oREV51rRrLG0w/ML6LNXaTfG8d3q3q0CWPioOgJcvv6DlWXq4
         SJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWo9Cssk31uUV/7b3sc+ymykbOjvu9xQxQL7ldaG2HCoR25PbZB3aYQhFgfihu60krQSpzQWLGbQeYLeF6kXH3ballv0wnfS+yY
X-Gm-Message-State: AOJu0YzE1aGk0CBLp5Y2gLcfpt+GUEL+MUqdWvtGsv6sSpQioYUlJ3Mr
	VgKe+CVuv6eBN5MrXLhmIFOuJf19D8Vh537U/HEodFxJ5Gx+ffU3H6gB78cl8w==
X-Google-Smtp-Source: AGHT+IEXahaTsfv+ACjW5Jo0pP4vpFIjBRKHYHLU0Zox+Ps2SKJcI5sW4PoaEsMwUsJ1jmxh3by/OA==
X-Received: by 2002:a05:6870:a115:b0:22a:828b:57ea with SMTP id m21-20020a056870a11500b0022a828b57eamr344225oae.53.1713902563069;
        Tue, 23 Apr 2024 13:02:43 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a084a00b0078a04882ac2sm5482256qku.53.2024.04.23.13.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:02:42 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	ludovic.barre@st.com
Cc: f.fainelli@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v1] mmc: core: check R1_STATUS for erase/trim/discard
Date: Tue, 23 Apr 2024 16:02:34 -0400
Message-Id: <20240423200234.21480-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000079113f0616c90992"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

--00000000000079113f0616c90992

When erase/trim/discard completion was converted to mmc_poll_for_busy(),
optional ->card_busy() host ops support was added. sdhci card->busy()
could return busy for long periods to cause mmc_do_erase() to block during
discard operation as shown below during mkfs.f2fs :

Info: [/dev/mmcblk1p9] Discarding device
[   39.597258] sysrq: Show Blocked State
[   39.601183] task:mkfs.f2fs       state:D stack:0     pid:1561  tgid:1561  ppid:1542   flags:0x0000000d
[   39.610609] Call trace:
[   39.613098]  __switch_to+0xd8/0xf4
[   39.616582]  __schedule+0x440/0x4f4
[   39.620137]  schedule+0x2c/0x48
[   39.623341]  schedule_hrtimeout_range_clock+0xe0/0x114
[   39.628562]  schedule_hrtimeout_range+0x10/0x18
[   39.633169]  usleep_range_state+0x5c/0x90
[   39.637253]  __mmc_poll_for_busy+0xec/0x128
[   39.641514]  mmc_poll_for_busy+0x48/0x70
[   39.645511]  mmc_do_erase+0x1ec/0x210
[   39.649237]  mmc_erase+0x1b4/0x1d4
[   39.652701]  mmc_blk_mq_issue_rq+0x35c/0x6ac
[   39.657037]  mmc_mq_queue_rq+0x18c/0x214
[   39.661022]  blk_mq_dispatch_rq_list+0x3a8/0x528
[   39.665722]  __blk_mq_sched_dispatch_requests+0x3a0/0x4ac
[   39.671198]  blk_mq_sched_dispatch_requests+0x28/0x5c
[   39.676322]  blk_mq_run_hw_queue+0x11c/0x12c
[   39.680668]  blk_mq_flush_plug_list+0x200/0x33c
[   39.685278]  blk_add_rq_to_plug+0x68/0xd8
[   39.689365]  blk_mq_submit_bio+0x3a4/0x458
[   39.693539]  __submit_bio+0x1c/0x80
[   39.697096]  submit_bio_noacct_nocheck+0x94/0x174
[   39.701875]  submit_bio_noacct+0x1b0/0x22c
[   39.706042]  submit_bio+0xac/0xe8
[   39.709424]  blk_next_bio+0x4c/0x5c
[   39.712973]  blkdev_issue_secure_erase+0x118/0x170
[   39.717835]  blkdev_common_ioctl+0x374/0x728
[   39.722175]  blkdev_ioctl+0x8c/0x2b0
[   39.725816]  vfs_ioctl+0x24/0x40
[   39.729117]  __arm64_sys_ioctl+0x5c/0x8c
[   39.733114]  invoke_syscall+0x68/0xec
[   39.736839]  el0_svc_common.constprop.0+0x70/0xd8
[   39.741609]  do_el0_svc+0x18/0x20
[   39.744981]  el0_svc+0x68/0x94
[   39.748107]  el0t_64_sync_handler+0x88/0x124
[   39.752455]  el0t_64_sync+0x168/0x16c

Fix skips the card->busy() and uses MMC_SEND_STATUS and R1_STATUS
check for MMC_ERASE_BUSY busy_cmd case in the mmc_busy_cb() function.

Fixes: 0d84c3e6a5b2 ("mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard")
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/core/mmc_ops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 3b3adbddf664..603fbd78c342 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -464,7 +464,8 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
 	u32 status = 0;
 	int err;
 
-	if (data->busy_cmd != MMC_BUSY_IO && host->ops->card_busy) {
+	if (data->busy_cmd != MMC_BUSY_IO &&
+	    data->busy_cmd != MMC_BUSY_ERASE && host->ops->card_busy) {
 		*busy = host->ops->card_busy(host);
 		return 0;
 	}
-- 
2.17.1


--00000000000079113f0616c90992
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DxuNuBlySpn/GYqPcDcRZd8EENWqnZrjtjHMk0j7ZfrPGXq8sQkbG3OX+DOwSaefPRq1pLGWBZaZ
YuUo5O7CNHo7h7Hc9GgjiW+6X9BjKAzSaDy8jwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdrYW1hbC5kYXN1QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUcRYSWvAVyA3hgTrQ2c4AFquBsG0wDQYJ
KoZIhvcNAQELBQADggEBAIKB2IOweF2sIYGBZTDm+Hwmhga+sjekM167Sk/KwxxvQFwZYP6i0SnR
7aR59vbfVQVaAiZH/a+35EYxP/sXaIM4+E3bFykBuXwcGEnYyEn6MceiOCkjkWQq1Co2JyOdNvkP
nAxyPoWlsJtr+N/MF1EYKGpYMdPM7S2T/gujjO9N56BCGu9yJElszWcXHmBl5IsaQqMS36vhsV0b
NxffjNkeAdgfN/SS9S9Rj4WXD7pF1M0Xq8gPLCLyXrx1i2KkYOYJsj0PWlC6VRg6E1xXkYDte0VL
fAAG4QsETU27E1HBNQyp5zF1PoPCPvq3EnWQnbLgYk+Jz2iwIUwiqwr/bDgxggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw89WX2Pp7ue922QVkwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIwaKyoRsmnXG/tXBXuLRgTkgm4CkZq/0+BJIUna
BiqnMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQyMzIwMDI0
M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQCABNeUtDi8Ic+vFhVsa2ww/3GEt0AxBCYuKpd2QOQ7PZb+/ewKzAhCtg0N
60disO7vj392UzMn8bGoA+qrFj9q7+hHQLRE8vudtLajCjuUBu8gTuC+15qJLRXMyP6ZR8uMBjs7
er+qYQWJxyfj+gUyCNQbzF1wX7sPo8R0nxQ4LsxkazTnfybpJGqfFZ1qQ45Ok38EdmSHBuwJmBHC
vOC48w6pstz2Y+5bKt3km49VXJECpbIvcD0CfO2b8Jg+MJvscYOsW5WXV2MM1P2QjM2pU+cibL4X
5hOhj3I0OPRETJHzPOUCX0O8VVFb+3EHzsyMQGALfAmTf9UYzMOyafqT
--00000000000079113f0616c90992--
