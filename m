Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C833291F
	for <linux-mmc@vger.kernel.org>; Fri,  3 Jul 2026 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783107739; cv=none; b=lfVik7G87dEizxte8poGnEldGKgtaZYJmYjR+FmYjyCF3wRuMSWP8/Yi6PR3Mden85iLGqYtWHZncXKFnCr1H2gkhc5W6g+h1ULXRIt0RiagamhaXEBcIfZKwej8WXD/XKKwkFpjx5av7ldJGHhWi3f2sRq0zkE18N7EquyYxEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783107739; c=relaxed/simple;
	bh=tVq3ml5TJnZAT6aj46tV37eRc8vSQAjGRbxPs8s3WzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYys9Zu2VLaqR6oVqCTu6Vo5UTtKv4KljmKr0Gzho9lN056QuCvinXDf2c2IPO4K8j369C9BYRsYg9aL0b+KntAU6y1iQuh0t6kgdwp913klZhNhtMTwBTMxelGXAmqgM65O5UqvV3lOpi0o52Uj0l5Aov6bNoe03/0Cvz4xH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ri6qsvH0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W1/AeOSj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ri6qsvH0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W1/AeOSj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HjX0v677822
	for <linux-mmc@vger.kernel.org>; Fri, 3 Jul 2026 19:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fk9/GLsPy9M
	HMLueq2DDIsdR8wBa5mOqZj4lU8apFQg=; b=Ri6qsvH0IQB7xkBldT85DbEuPR+
	V38c/QBjrTx3QAafrYlhGfVLLgywea6jC0l65ZPVm+U3OmpMLlZ2VV+buorCWD04
	bPspMhxpQP3PxJgSkqo5xItrUqIdk/3FX8SpHBpXs4HooIhx3sX33Vm6KIAIvuuO
	V+zfVc1wJpwX93k13QZzhz9J8673uBXFJQFPim6Amvhm2v5TN3gUh0UgLqfi+nD3
	BBivAzeFqowQTT99u2jDYsv71gJbnTCR7VBBQLywg7pl2+GwxpAmKoOyAAxYXYRC
	H0KctSWMLFGXaAlJi6ZSIXtE97kU1lZAseBWBP7EoFJBmuUPuQyLsm2DrLw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkh8ut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 19:42:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-381e93bfcacso643246a91.2
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107734; x=1783712534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fk9/GLsPy9MHMLueq2DDIsdR8wBa5mOqZj4lU8apFQg=;
        b=W1/AeOSjrTk8EsOuyoajchk9r8job3ND2jlKqh+1LGlGTbGDqsbUKENVY4no1/SbVE
         TTTfEVnsPBNCopKbq9MQBW3VToXKVCMB2njJpPSAN23uPAcBdeuKWPif1V0MXlwR9m5b
         kO4KB4ww8WGnSEJ+PIwtk/Ul736hcai3JTLr3Py/ktqXoa8OfQFsL4WPLqSmk9ZlqkPO
         gmfgzh93Fy6uTJB8dQIehAyIIi2kyF5sp+uDVpFbpts6yD4UlCvd9wAHconubFiRFFOi
         z3HzbKworvTslHH3ywxleIM+0FMKFPV11opE5ESw3e6cg+DXgRTA2voZt5qvnwVjq3T6
         UcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107734; x=1783712534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fk9/GLsPy9MHMLueq2DDIsdR8wBa5mOqZj4lU8apFQg=;
        b=lMxcNoqnb6mmHkMYyme3E189mU7tBJjO/wl6BQTxf9qMAPRs4pjVs/1K9BMwCvFMgl
         U509LLH3UGF4Vr4l7B/yw2B+A/xRoGzynqkOvqAp9IMpYi8GcNTlNG95mfCTqyFj4VOL
         q5zpFimSANZWU3ifYoKafzpg/vN0TAMLeec8NGq33hbiWYJzwTttULf8+DBFI3YiUTAb
         2VuBiX/aLpPSGvv1pBSWw1W5XRVE/85iB7mszFNhw5YlOV4lBZ5EjuHRgPK+/IQF9rmO
         OF5jMRvF4jH1toLzfzQ/5PC4/w8Grl1/3JDxpI4m0Ya/3R8c1m78zug40rryJsyMs4Gm
         3mbA==
X-Forwarded-Encrypted: i=1; AHgh+RqGN4WpHU0BVjWU/cmHnEPkgrQGikbsi6a6BwOXW3gytGLKaROKcBbVNwRHLBtKdAPjhsZOUZtbFRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMly8GxdoPMh3JInKu+s9HR0qGkr+pnUHnlRoQ3IFfjC49WNP0
	l4RcDyI1bAmdLjVMVrKJbKYNHTyxRTDmlDYNkf0EQHb9n3PbCb/8tldDB1QrbuXRVMAV4fzNew0
	8JT68iI4wIGWyZQVS6XjxKfGtu7M5LsFNCOj18sWjcUv/USNyseVjKiVgrnti0fU=
X-Gm-Gg: AfdE7cnsKz3l4pS0r059nFF7PtUbymH1dc5ZguzbjRSQFIPHI0/ctKRR/c+yL6apO/m
	VVg/J9vd0EMpc7amFq+0Szf1T5XEmtskgcB2eNp9kguQrzBAladnlPX45WzSqtSmBhBqxuaw1aW
	7ptxy6LM4ySh0+4zpTjtKV5ZcmF5ySWI8vXLPFBWmj//vWZZhc4W+AhsVno9qTODtvbyzJFsoTT
	VGSgshP4vo5cCcdjqY6W9/Ww04NEGRHOp1TF9S0QbPRpzeMWYxY1dk3CDCtRdcVcVBPjFhwdib7
	ZQmqUhtkVHRDnnKHkBKEP0OCazlGNgy/eARMMtTXn+0EEKYPbO1cN3aygo8uRvlUk+9W1p6vjcP
	BdGAJrWSDyk9B/Hi9jh0rU9U5sjXq1HoygWAcRQ==
X-Received: by 2002:a17:90a:d408:b0:381:854:dba4 with SMTP id 98e67ed59e1d1-3829e933299mr718629a91.20.1783107734434;
        Fri, 03 Jul 2026 12:42:14 -0700 (PDT)
X-Received: by 2002:a17:90a:d408:b0:381:854:dba4 with SMTP id 98e67ed59e1d1-3829e933299mr718564a91.20.1783107733767;
        Fri, 03 Jul 2026 12:42:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:42:13 -0700 (PDT)
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
Subject: [PATCH 07/42] remoteproc: omap: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:20 +0530
Message-ID: <20260703193855.110619-8-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX64ew1kkbfJoN
 CP5GluGxnqAfeakzkoVOxsv2ovY6u5iL6Li7uK4TdrntomjkeP5u7Ln6nnX0CzZuizm5rQuQzzw
 TndnF3Mu/HhxBmE3aS+A7D6PKJhTSYJkvBL324rXC4IAMjyveOzOuA/nPHsInQedC3qhY/Sk6HK
 ThSxocVZRflHew/ZGMstgfvO0I+bo6RtNbEtzurMFDGE+cjHNBjgVfvonjDDBQEfX/9MHeKQqW+
 V5Fb6D4Ascird95JOt3gl0MKjKwEeQf6+NPnX3KducPW5/6iR4SslN52Xc17HZgyUiOtsWjjGn7
 fZscB3nxQc0amGw8lX2GWfhdxUqpGcUZczH1JoT3/rn6wWjffdJMo06PZwzTpWT49T01LHr28eP
 8TnAc0Hi75fpqjr+k6pekHobhZVJ17vpSGERGzBsAnWFNVfIyR7MTPuzlpVheOm/jU1wHLRdugn
 VfUezAEt/IhE28OwiPA==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a481097 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=NeIE-sOIGFWZl2hhsKQA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: -WE04l7-U0n5YGFj54xXuF_jGqkXB3Zo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX05aMfaTV9K07
 2Xyj2Qq1uDx4OqDNvPNcoIO0C2t/SB4JU6kKRZAex876/ZLAYhcoT37LDJ3w6aK8JH4AFbCi3bt
 ksCKJWB02sku0HCq/nCuCcDnfwfI9r8=
X-Proofpoint-GUID: -WE04l7-U0n5YGFj54xXuF_jGqkXB3Zo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030198

Replace the hand-rolled omap_rproc_mem_release() devres action with
devm_of_reserved_mem_device_init(), which handles the cleanup
automatically. This removes both the wrapper function and the
devm_add_action_or_reset() call.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/omap_remoteproc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 6ed0f28edac9..74262f873d40 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -1276,13 +1276,6 @@ static int omap_rproc_of_get_timers(struct platform_device *pdev,
 	return 0;
 }
 
-static void omap_rproc_mem_release(void *data)
-{
-	struct device *dev = data;
-
-	of_reserved_mem_device_release(dev);
-}
-
 static int omap_rproc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1359,15 +1352,11 @@ static int omap_rproc_probe(struct platform_device *pdev)
 	if (IS_ERR(oproc->fck))
 		return PTR_ERR(oproc->fck);
 
-	ret = of_reserved_mem_device_init(&pdev->dev);
-	if (ret) {
+	if (devm_of_reserved_mem_device_init(&pdev->dev)) {
 		dev_warn(&pdev->dev, "device does not have specific CMA pool.\n");
 		dev_warn(&pdev->dev, "Typically this should be provided,\n");
 		dev_warn(&pdev->dev, "only omit if you know what you are doing.\n");
 	}
-	ret = devm_add_action_or_reset(&pdev->dev, omap_rproc_mem_release, &pdev->dev);
-	if (ret)
-		return ret;
 
 	platform_set_drvdata(pdev, rproc);
 
-- 
2.53.0

