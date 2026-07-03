Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE60330B14
	for <linux-mmc@vger.kernel.org>; Fri,  3 Jul 2026 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783107761; cv=none; b=szAguJEGEGQpxRSP4iFgp1khbIxP6xyAhsQoEwD+VUJXislsvG8BUNWakwbjSKTQ6YLGzusFCPKS634MyZpPIhKwlp9HFZJLxZ6aKIMYLxG9TiuCKuFbq3pIA6xUgZ+dy+CGws+zelc8ThU+eEQN1le+GU/nCyo2+Sl6/2JFG+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783107761; c=relaxed/simple;
	bh=HRbjhWrQ/b1BPdLECUGZ1vj1pvlPVpDo/p/rUJhwlC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+vzdUg7XUOKTt4tP+La/Ar6LYRNqMBnwYAHE+dM7EJJo3NDwm/1FDHqB7seKu3h5TrjkQk78PHt5LQL74EQBO4+8oHEB7OhAJobvey0gBkDE1ICLoRRrtanb1CxW/fPzEU+phFWS62CKOCxn50l1zQaFRZ8IGRKnwrQKwcN/nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jKWf2GSY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FTZ2JJuF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jKWf2GSY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FTZ2JJuF"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiLI2678021
	for <linux-mmc@vger.kernel.org>; Fri, 3 Jul 2026 19:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=BM7jtgPz5pu
	XtMgobfAPTx0DKFPGBIZQqDVHqsjFOZI=; b=jKWf2GSYBWt0WCeSTarF/ZyxiwK
	ySviO6bqYuR7hXocJXWdOzctBTkhr9x7EBJtne4ZOFmY2TQnOa/Gh839O06jG1Z7
	dooiFHxttTiabG9BCsQjg42O4/YG3Njl/KqjnIDTpKtWlrEa7Oz6uExs+CjZECUi
	xjJD6IMEajr2OkDLA3WKBxxOfzl0dQqBxjqVSPjOoU9RaH/p2EFT7u56Y4OH0mzN
	ZRdyYM3r4dJMbR3VmiLwRyPjjK7ZwaTZ5+BWp14AX1vqD6b0N/1+keNALbhSW6GJ
	73bXzhYTiDhE7iSf9SrCIj4lzRwnt5YUmTfWTl/y5PQ/BXjK1zfMPAEFh9Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u32jj8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 19:42:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37fc0aaa94cso1428858a91.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107759; x=1783712559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM7jtgPz5puXtMgobfAPTx0DKFPGBIZQqDVHqsjFOZI=;
        b=FTZ2JJuFX5O8xKaW8uvZoVjc7M+EqxImi+VabpN8xkg4iVTZqZDcjdBK/aqGlkgBVt
         9lWi1C+59I9cCOwEZD57z3eML9ewA6OH/m8FhRh3CSHGUa8HuOEUOeL0LY/bjzVozu0G
         C1NylKd+9EcnsvaV9UvIVPgtBomwe8x4IhTcp7QjhOiqqiyiOO2C2M0ZOPF751oBFJIp
         qYd8oMstV8x/wTvfcmJ7Et7XAQl56t9N27HeNeF0cpOYgRVMKh8wb3dvYv2gvrMBRzpx
         w7KEer3j7eEdfY4wjOai2Xcrjq+QrtbswY1defaabeE3KWHFuIwgR1OAip6ERTnt/vFQ
         My8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107759; x=1783712559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BM7jtgPz5puXtMgobfAPTx0DKFPGBIZQqDVHqsjFOZI=;
        b=QQGFrltVHjyprKbuNCJFt+BXbEaStBMZt7nUjClLl1YJJObmgc2axV8yP+u66+o1MK
         dakdIvDgtQyXzDyFxZPyJqGZzHmRRYJA1P0PmiiR3A1AOHFSK4tKYsIKuedyW6BSkCkm
         AZI1E+zQigqEIXXody7JeNnCf9Qujjx39cF0d0VgMMuXmr1cisMhl4CmFmx9hybpUyv6
         n/SSGPS/zXPyfthY83NLHe3YaSPaN8PkPhYtx67SMi8tQF5ohxtS+8B/zwBkrWtX948k
         n7f5mEn/pMw0WGiDokQpePcyil8yu6uON/Aa/OSdfbttPvH9uJHPf9H0qs5XbiSCA+1e
         gucw==
X-Forwarded-Encrypted: i=1; AHgh+RqMUb7heJJv2T/ldkkyFLNgs11N9UF4nDA9WNGLk20fHsta1Ubulb7a1oH21QHPDgt3Kt8Vs1ojrIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUlP+l0DI7wgS8SOEHNIZHmIJ8TMe5yJBLg90KhJeq75Jp11zt
	kv59zkY5+6bwxhV9KfJn6B6HgbOopYGyd7a0nlQbhRa/9YAK2CfVBiN76qnEMHF8K0BgEyN/KAs
	sEaRCnOAyQtTn8v8nflSFNleNAUJ0U4AX4B/fXLoiS9h12Sv35LPghQKDKcze50Y=
X-Gm-Gg: AfdE7clHruQ5+zSSzbh8LfGUUPWePhCdIn5x1sOVxYQWPS345nsI9cIM8jx9mIG2i29
	lnBx+h25zYS++doQQ3Ub1fKC75T+KhJ4WUp1HXKi8od5gOI/65wWrddbUWTFnVseTdlUNyU8z8G
	NLOSeezgMXEhv1m+dlPRbJRFHzrPBd5ZAC20YHsA2UR0nSts8PP0rM6envJD7mMF63P3miFjk5Y
	ph+q8HU+ReFmT2QQVkkZU7MN+t+GDRs+hiAF8q4+Gq342x5RMMdlm7qVWTb2DXaDuRmygM7B5Sh
	OsBUFSS0/hU2P93ThBvr2P8//n1v9ZJNxDETVsIv/4BUXbSIYbY31m6y3fI7He6qkjrRuiVBEm9
	0ZuT/Wi9KLsknkz+MMwssj7g9pnlZYgIWPchlYA==
X-Received: by 2002:a17:90a:e708:b0:37e:a09:2640 with SMTP id 98e67ed59e1d1-382807ae330mr703180a91.7.1783107758452;
        Fri, 03 Jul 2026 12:42:38 -0700 (PDT)
X-Received: by 2002:a17:90a:e708:b0:37e:a09:2640 with SMTP id 98e67ed59e1d1-382807ae330mr703088a91.7.1783107757826;
        Fri, 03 Jul 2026 12:42:37 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:42:37 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Paul Cercueil <paul@crapouillou.net>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Paul Kocialkowski <paulk@sys-base.io>,
        Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Michal Simek <michal.simek@amd.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ge Gordon <gordon.ge@bst.ai>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Peter Chen <peter.chen@cixtech.com>,
        Fugang Duan <fugang.duan@cixtech.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        kernel@collabora.com, linux-tegra@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        imx@lists.linux.dev, sound-open-firmware@alsa-project.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 08/42] drm: logicvc: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:21 +0530
Message-ID: <20260703193855.110619-9-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 89FlesI6qQSpIpNEyBOZHdTbHj2tZOzp
X-Proofpoint-ORIG-GUID: 89FlesI6qQSpIpNEyBOZHdTbHj2tZOzp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX635KTFqQbW3i
 /MdpzyFxaw14exvQm5UB+kbSO0tu9coYeH9tsF84SBBpx49hNgSqj9NIAyTxQkfS6lEcLfwYkMf
 2TiD7lGKPu2ntAwGf6FXhJ7vCCRAStE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfXwsqZhcnbH8bU
 0xNcuA+Q75PRHG0TF7mHvlsg3ZWZ2wIyhOcO5BXM59iKElgwVy2ciS/6EisjT5zyDIa8JJ6FECb
 XFb3YdxzPqNzLg0G0P+zyFNlVe10xDX5VKdBPHI/Lr7kdLNlDAtSDL0lQCnlQSZLRmOCTXDGEPs
 KjWmb6oOX6zIp9MUhuNRvjxsc73EPy01wG6nxuPsO3oK24Wt5rIceDU5ZUI8pCvmc/8/brlyHLD
 RN7bJtAaCQc4ckmIQ8oLrAXgVnkDdIhM0P2f7YdAhzicSyJT2kONVyLoIU4ogZ8EvHW5B7JxkFR
 wIHrEZlL5lSTX0/kJNqMfTevtnG1a3Suvz/aOS0yc80FNU4XKnfZRFwyi65i3Yhdju127XvCf/N
 KEi97bKNxFJ+qVXRihECsSQrQ7E0WrhziNmJk1lwEbaOJZEjN7dRhABc1cYjlV8Vi25YdQ13JCE
 D9+rhMitG5JxZ58LaAQ==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a4810af cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ReI0EElcLHst8dYcsfAA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030198

Switch to devm_of_reserved_mem_device_init() so the reserved memory
region is released automatically on probe failure or device unbind.
Replace all error paths that jumped to error_reserved_mem: with
error_early: since the manual cleanup label is no longer needed, and
remove the explicit of_reserved_mem_device_release() call in the remove
function.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/logicvc/logicvc_drm.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logicvc/logicvc_drm.c
index bbebf4fc7f51..d6dbe52ff0a9 100644
--- a/drivers/gpu/drm/logicvc/logicvc_drm.c
+++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
@@ -306,7 +306,7 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(dev, "Failed to init memory region\n");
 		goto error_early;
@@ -327,14 +327,14 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 		ret = of_address_to_resource(of_node, 0, &res);
 		if (ret) {
 			dev_err(dev, "Failed to get resource from address\n");
-			goto error_reserved_mem;
+			goto error_early;
 		}
 
 		base = devm_ioremap_resource(dev, &res);
 		if (IS_ERR(base)) {
 			dev_err(dev, "Failed to map I/O base\n");
 			ret = PTR_ERR(base);
-			goto error_reserved_mem;
+			goto error_early;
 		}
 
 		logicvc_drm_regmap_config.max_register = resource_size(&res) -
@@ -345,21 +345,21 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 		if (IS_ERR(regmap)) {
 			dev_err(dev, "Failed to create regmap for I/O\n");
 			ret = PTR_ERR(regmap);
-			goto error_reserved_mem;
+			goto error_early;
 		}
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = -ENODEV;
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	logicvc = devm_drm_dev_alloc(dev, &logicvc_drm_driver,
 				     struct logicvc_drm, drm_dev);
 	if (IS_ERR(logicvc)) {
 		ret = PTR_ERR(logicvc);
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	platform_set_drvdata(pdev, logicvc);
@@ -371,7 +371,7 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 	caps = logicvc_drm_caps_match(logicvc);
 	if (!caps) {
 		ret = -EINVAL;
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	logicvc->caps = caps;
@@ -382,7 +382,7 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 	ret = logicvc_clocks_prepare(logicvc);
 	if (ret) {
 		drm_err(drm_dev, "Failed to prepare clocks\n");
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	ret = devm_request_irq(dev, irq, logicvc_drm_irq_handler, 0,
@@ -450,9 +450,6 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 error_clocks:
 	logicvc_clocks_unprepare(logicvc);
 
-error_reserved_mem:
-	of_reserved_mem_device_release(dev);
-
 error_early:
 	return ret;
 }
@@ -469,8 +466,6 @@ static void logicvc_drm_remove(struct platform_device *pdev)
 	logicvc_mode_fini(logicvc);
 
 	logicvc_clocks_unprepare(logicvc);
-
-	of_reserved_mem_device_release(dev);
 }
 
 static void logicvc_drm_shutdown(struct platform_device *pdev)
-- 
2.53.0

