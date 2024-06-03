Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A784FB7
	for <linux-mmc@vger.kernel.org>; Mon,  3 Jun 2024 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717452581; cv=none; b=JcZghbiNy2I63cOzQn5hJxUaPF+jj6SbIBc498y0M25v4SFBxEiLDWwPNHiWIfC2FiMKoPpoWXV7DWfUf/9sAmG4D+jcxRXJnvtXu9lbRWFYfJ4brQVDFRRT1lTEPZArD01MZkq2d5vczF1/Az/fUGBGqBEyUmBkKUOjJ0Puzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717452581; c=relaxed/simple;
	bh=69TuKtSr11+U2X/tiebS3bvv1QNGztI2xlWNWGtqEE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=djMmUfQGKxpnaN4HIJIeN+eyA2dVi88wATgaUTs/+Ejev6CuOkkKJuvtVqEOC4Smq4CQ8NWAO6flVYLmULlRpvch2rUqAeHhnK85wD71sjfFe/vwZxeIT+66kk+9Rnx0RNeU30F6uOyV+iLCuofruLnGx+4Dto22Y2TxKn7Vvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Haq1bvac; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Haq1bvac"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6af4fcb45ccso17054086d6.0
        for <linux-mmc@vger.kernel.org>; Mon, 03 Jun 2024 15:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1717452579; x=1718057379; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hi/79bUKlBsBQoS0gf+lRKxMgt2/mvp6AbbtNgC+xlQ=;
        b=Haq1bvacwbQBOvU0hND8OYzDqN5M7oeAuFncnNhy/nariC5lf8HXNgvkof7q2ohX53
         slBVgIr1SJ+nRcrVwsAVrs4QFjERlgDIbjdbGGe4Jf1hWvRWX+uN0GeDNjS+j9FxaTY9
         ENE5Y5PUIEUYXuVzCnAQOiOjkML5SoBNA4gWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717452579; x=1718057379;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hi/79bUKlBsBQoS0gf+lRKxMgt2/mvp6AbbtNgC+xlQ=;
        b=F7NPf0cvteBoZuON3qs91exv6EaL1B8cqLZkgMuRf0txC2TqhKxipvvy2AzigbRttQ
         q1H3JASeWtmJ/QqNWQbhL5ajgRQfmJmQkQLgIch2oEwB8Kv7d4Armw2jjKoGA5VUO95w
         LmBBX8RW5gSijfBxEJTxTfEENVJahriLjjrdTOG5e0voUV2YpUPhcG87K4qCjlIyCiWY
         5X4Qnz7eoG/sjmTYSYEBMSpAEqVXv+bh51cv4nRLN73KORDpOTrRVbKaEgSDcVhAnIdm
         U6l41fMt/zDwzobukLUlcmcaIxoLwrlFcCgRIxO+Xm4MYmyytVvTbQ8clP99w+sNjJaH
         yr2A==
X-Forwarded-Encrypted: i=1; AJvYcCUbQzzx4jn0j1ulOXjmrrScavQeGTfoVgu2e6TsypgmiMk324V+8jDkFA4rdKJnKluZyyh0oRz4SxVsCDr7+7zYgb+k9o6myZW4
X-Gm-Message-State: AOJu0Ywe8CRWT/T2OeYX7En1PNRiekU4TJS9DEAGSy1buFGBsXe8pNMf
	XaRsy2+17IRM+Mp3KOnGBpusmHQC8Cxbuqc89r4LHZP6xL5bMX2KmHiH2rgi4w==
X-Google-Smtp-Source: AGHT+IH2ctGvhhF/FI6MqjBeCmjtwP3C2s8sKstO25uB1fm7IlADo7lZddD9coAZAqSTQBQvUxkJ4g==
X-Received: by 2002:a05:6214:c4f:b0:6ab:9c77:c32c with SMTP id 6a1803df08f44-6aff728c2f9mr17207756d6.10.1717452578856;
        Mon, 03 Jun 2024 15:09:38 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6aff97cc497sm546986d6.60.2024.06.03.15.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 15:09:38 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	ludovic.barre@st.com
Cc: f.fainelli@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v2 1/1] mmc: sdhci-brcmstb: check R1_STATUS for erase/trim/discard
Date: Mon,  3 Jun 2024 18:08:34 -0400
Message-Id: <20240603220834.21989-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240603220834.21989-1-kamal.dasu@broadcom.com>
References: <20240603220834.21989-1-kamal.dasu@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e79db1061a0396c5"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

--000000000000e79db1061a0396c5

When erase/trim/discard completion was converted to mmc_poll_for_busy(),
optional ->card_busy() host ops support was added as part of
dd0d84c3e6a5b2 ("mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard").
sdhci card->busy() could return busy for long periods to cause
mmc_do_erase() to block during discard operation as shown below
during mkfs.f2fs :

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

This problem is obsereved with BLKSECDISCARD ioctl on brcmstb mmc
controllers. Fix makes mmc_host_ops.card_busy NULL and forces
MMC_SEND_STATUS and R1_STATUS check in mmc_busy_cb() function.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 9053526fa212..150fb477b7cc 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -24,6 +24,7 @@
 #define BRCMSTB_MATCH_FLAGS_NO_64BIT		BIT(0)
 #define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT	BIT(1)
 #define BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE	BIT(2)
+#define BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY	BIT(4)
 
 #define BRCMSTB_PRIV_FLAGS_HAS_CQE		BIT(0)
 #define BRCMSTB_PRIV_FLAGS_GATE_CLOCK		BIT(1)
@@ -384,6 +385,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+	if (!(match_priv->flags & BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY))
+		host->mmc_host_ops.card_busy = NULL;
+
 	/* Change the base clock frequency if the DT property exists */
 	if (device_property_read_u32(&pdev->dev, "clock-frequency",
 				     &priv->base_freq_hz) != 0)
-- 
2.17.1


--000000000000e79db1061a0396c5
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
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIO3Ti3O3IiTFW+IBoI5+FZjFyUJ6xiqyuJtU+jVe
MT61MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYwMzIyMDkz
OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQA6CLXdrVX7+QiLnA9d4XNtEgvlWNNPVmRqXNQk0lyVJFJI3V6HARI1f0co
IUMtXnezoD/OlkeQIx62Zsp1s/XHkORBrVg64YKUGYqJYerkCObGTIh5y18AKNtI1tfdJH8edv2V
htw9Onk2bFnuXKpmJh/ztWkYXOlKAg5j/Vr34/rAlaZHgUmhnaP94HjPW75AE+CVWQEoKZEcddLU
cFEm+xPfHW2ycVVIQ3OrKw25Nn981g3HTJP4JRUoV1yvKDGwWUNH2ONH3G5VqRiPQ7FMmLnWzB3N
YkajTU00SKur1Khlj5Gz5O9z73iTZLSSrRqMbUJFcz9SeMjt5cwbny+H
--000000000000e79db1061a0396c5--
