Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB933BBAF
	for <linux-mmc@vger.kernel.org>; Fri,  3 Jul 2026 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783107979; cv=none; b=Q2cR6wJYVBSiyZCB9B/KlIe24ZJxBRLCw3hj5d9nWVa9Dn3QAd+naQ2HqAhTrEet5Rsx58wRAtIqtKmHo5az+uXLZfngv96zJlLKW2fr2YqQNXJ3k9rMwg9Gn7tfLPxBjY1lDYqHXE0IYK+6b1Ag62HYaMEq+/XUD6GJ3Bjtu9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783107979; c=relaxed/simple;
	bh=QOh7GqumUDyEZpuyEtrsdIab1p1IgRVw5iyZACoDzdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsTqBzCb1Z7AzZsBDEA+7rpTm3gas5FPRQbHW1j+tWq4EawSP4ZxZEJu1c2tgnrRBojP1dWZqI3g0h4G+8LcTiQgMSY7qQEMP+UImedeb2uD7X5j6golNUzR41zXT3aze9a/4X3mb35q7Gzu47SDoGxlkJSXNQa4bugEAya1pO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sb1uIwnv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Al7zRSzW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sb1uIwnv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Al7zRSzW"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663Hj2vp696518
	for <linux-mmc@vger.kernel.org>; Fri, 3 Jul 2026 19:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cv8Z70k8ciR
	2WfmKiPLW243jrDjjieLnK77w7rwJLZ0=; b=Sb1uIwnvYj2uETwfHvteOGjSG6K
	JXew0PFUKn64Jx+BTzBOG9vyluIa46v09u3diiZJGxx2REwMh5MVVEQCdko2m1m2
	X3WTpN60KDEWQ7NHz0ELskiwfWEnv1CVkF9EDUiQoaFGnl9iOqG+PwASCsZanogx
	3Pk4bq/g8TllNFlKP7Jc9oBfx17JufnApzflD4ZLqzWUrCXaUXLhncmsjwRdgVCL
	ZDSXeCpRVtlczU6Szn4CjO5K1A4lLTNZunSigmk3ttg1AiKNmcK08JevFSjUTgmc
	N84jDNimEarl0/409TEhjBc7JaEnERPmAY8QmUuTT7AsNwk9w6mSewmHG6w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6a84a5sd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 19:46:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37e5ef8299fso853550a91.2
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107977; x=1783712777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv8Z70k8ciR2WfmKiPLW243jrDjjieLnK77w7rwJLZ0=;
        b=Al7zRSzWYFLs7yPtFQypV+oT2Fejo8jfMyTLbDIGQvg7n5k+9aWh7JdLIKCGKUALxw
         F/Hx9cxzW1QdATvXRBRzhtykzO4/3kuBS0WEXL+xtV0/nOkCrAKZr/SHuxVTl9Lr6MWN
         kafNyKqoUTw9uGLEiM2ALosdtvgSS42C3bSOJtgHFJVD/iRUAv1hO+ofnzLazNfEytr1
         DWLRJvQwcQ49fmD4G7NCUOI88FY7VVR7m59oOzAR9NqB9prjE560ehW4sDF6oOkipuTr
         JNHTcTW0lPoHP4DBap1q9UC5JJnkA8ntUtUsSwQZTtEPsTDVXHyXj9QhoViDiiXPYk7D
         bDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107977; x=1783712777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cv8Z70k8ciR2WfmKiPLW243jrDjjieLnK77w7rwJLZ0=;
        b=LbOrJuASqScbF9YybRCRTb4HwFOkaAnABOu7H2MFF59ORujeSWXg5gy0foW0qMOepr
         IBEJcKUTEPhUb6jrKRhSYbJqKPAADbjGNXOrYA9pW9NtFU73otFkDa5mQlxQmmtYHTsB
         6MPrCyyD9UqKWafyzDlPjb28WVRPLmXyuOWX6kmnvyr1Bj5/6nALM7iRvalwZgaL/4wf
         nP3f4EjrunfIA+LlkWfklPNf3h3kyMQYJl99TtvQ0Df8jfdedA2XsvFkG9d63mQX/lp5
         +sBAw0aFznYeL+SD10H/yaclhg2zBzNK06KT2AOlMMU9f5PS0V2C3AJOOiYpBEDjKrNi
         vIWA==
X-Forwarded-Encrypted: i=1; AHgh+RqUzOAQnrElG3kUBBDUt3L3D6sfPo7rmrvcfAUGx+u0RlpRZwv1Mc/jhcw4m9qhsOsoNAKMXeSP6Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf0Gr7AlU6QdK89rXbT2wlVNc1k+hQcdgnkjvyugGq+ALBHBHR
	s/UVOekE7Cn8ik/36txl1EUlbuMBZc38AV1dl48IMIHymTjWytlxD+veyNNqI5WiY8Mz3jzNXsQ
	TL8m7bajBQv4952wiPvY0bM283QOECYSWB1LPRI2azPT9AYhQDk2vKys3DNQdJWI=
X-Gm-Gg: AfdE7cnnfHNMSjgdCbdtLTeb0Hh3EPL313tzGWBW2owLF8Qaw01wZbLGezGalpbFZMK
	E6glkjQDNWQ3z/ADjr42jIj9v2cNKfhf/o23qqgbhPXKAA7BgDJ5dPxgkWV9LWcjt1Sn77oIjYy
	OCj0YVpuhsx5FaKTz1tvb5rWg4DTCiUY93DbAzyz7ddswQBFB8RZRRiLMZd0yLNwJeuLZFv1hwR
	8Xx+Ob/j7rzAyQIhdgN/36fFD3zpunsVqvDMmPRxZKDT3W0KeiIqnIyvuHhGqrPNLt9if7PnzLQ
	xAk359VF11LPNgrqYmwvoVoW10Y45LxLNGbo1NpBjb24cl1fsSMiwXNuCSrVHOYR4AMSAKfWj3I
	CLDJ6WQmmwYcLw+lsf1NzJUyqupTLVUeDJ4faew==
X-Received: by 2002:a17:90b:1c81:b0:37f:9cdf:f03a with SMTP id 98e67ed59e1d1-3829f4e8836mr700678a91.29.1783107976443;
        Fri, 03 Jul 2026 12:46:16 -0700 (PDT)
X-Received: by 2002:a17:90b:1c81:b0:37f:9cdf:f03a with SMTP id 98e67ed59e1d1-3829f4e8836mr700565a91.29.1783107975869;
        Fri, 03 Jul 2026 12:46:15 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:46:15 -0700 (PDT)
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
Subject: [PATCH 17/42] drm: ingenic: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:30 +0530
Message-ID: <20260703193855.110619-18-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-GUID: JnIJqsLTyapg8yrDQLH_ertUL1ms6P79
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX6VF0daIVH1o8
 5ARpwA7GNdtiundFNxNIDdsSdF4LH+IqC22wDVM18gNGAORVSLOjI5gwKS0D3H0Q8TRk+NYjLHr
 YonyKOSPPk5UKbnfeFKWrTUGWQXcZO4=
X-Authority-Analysis: v=2.4 cv=a6QAM0SF c=1 sm=1 tr=0 ts=6a481189 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=iWCwWg-Lr60CcT_aNAIA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfXx6dCwLb/XNTi
 dm3zkzPzWq47tlME+H2s273/9g5guWaUg888TVn1ryCdk5SZyacfWGQUJOREEQq6pF8lwv59sCU
 XSWwyEqiaw/wZUztttO+FYhSldMh6wP8EkwwCPaZ8w2Hdp9zB7ImUPXFu8QvHCzNrY14DsJ8foQ
 FGf8egqy7kSappGYQa9RHlDFnRfxiTSV7zvpRB5W9At6LI97jAr13WhXOnPlYKLMCBG5tQvzks0
 RuSYed33h2sKFAD/O96Uz95ZYXr+Y74QLGMgDrjXZsgAs5LxQQOF7XBwECExtZeMnv81MAOj95j
 97Lfr3/U6Mxq+X/h1gf3GiG8TIksuniXnIHTIu0JmezmMb+RCVcvv1Nlhe6GazymKqwDUeh3tY8
 5cBDbPoMKBytc7NhqtuROgD6CORXCqJfCPM3b6rWxROwsL2jk6ITiwEDv0TQ07KtpF4l8FJNMFF
 WilNGZTsBhW477l2uOQ==
X-Proofpoint-ORIG-GUID: JnIJqsLTyapg8yrDQLH_ertUL1ms6P79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030199

Replace the hand-rolled devm wrapper (ingenic_drm_release_rmem +
devm_add_action_or_reset) with the standard
devm_of_reserved_mem_device_init(), letting the device resource
manager handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 7e569af22391..990c3b4625fa 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1060,11 +1060,6 @@ static void ingenic_drm_unbind_all(void *d)
 	component_unbind_all(priv->dev, &priv->drm);
 }
 
-static void __maybe_unused ingenic_drm_release_rmem(void *d)
-{
-	of_reserved_mem_device_release(d);
-}
-
 static void ingenic_drm_configure_hwdesc(struct ingenic_drm *priv,
 					 unsigned int hwdesc,
 					 unsigned int next_hwdesc, u32 id)
@@ -1127,16 +1122,10 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 	}
 
 	if (IS_ENABLED(CONFIG_OF_RESERVED_MEM)) {
-		ret = of_reserved_mem_device_init(dev);
+		ret = devm_of_reserved_mem_device_init(dev);
 
 		if (ret && ret != -ENODEV)
 			dev_warn(dev, "Failed to get reserved memory: %d\n", ret);
-
-		if (!ret) {
-			ret = devm_add_action_or_reset(dev, ingenic_drm_release_rmem, dev);
-			if (ret)
-				return ret;
-		}
 	}
 
 	priv = devm_drm_dev_alloc(dev, &ingenic_drm_driver_data,
-- 
2.53.0

