Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A79335091
	for <linux-mmc@vger.kernel.org>; Fri,  3 Jul 2026 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783107810; cv=none; b=Tps/dnilIS3v3LqBp/senW+dHRAbsaDpWLL+r0zfKy9lF4HjasLOaXhOUxR/TswEJbHrAlYC3B53xtY9kk6ZjfOKCNsD7tLFzj5wfkfzzT8ZDlZqDS1EYoqaJp2c17u9z2YjXPS1j74/Ai9fO+3Wde6rjcGV1G5XhSf0CWoTTqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783107810; c=relaxed/simple;
	bh=so6MW8lL0On5dP1UN+ooRHBEwT1W2FhfHQtdPS4G+WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEmCGa2RFk0Ueyymu/N0GiHgilQ9U65WC1WnL3hmw2UK9jiucR9j2NzfFKXffx0RZVJ8ev4iwJx3tK9ipXpTQQC2sBweo1+k63F4ll/SY1UrsDTVylN/1ABwTBz3j1t70HqQ1gLg8FPuW3THQLAIeTMOPnegAkWLpomT4+0qhLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nOeTG4ty; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ApQqXwOA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nOeTG4ty";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ApQqXwOA"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HjeVg497469
	for <linux-mmc@vger.kernel.org>; Fri, 3 Jul 2026 19:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bn4n8Ensq4b
	2jWU5voHmUQF7/CVhT1UW+T0M+N3rGrg=; b=nOeTG4ty30vKw+ttbYanSVJ6ILE
	BTAP2O4+nJPij6iXWRyXJ6gBds/5MB5tBMGqFWh+/u8gKduK/0McbMFjobNCnuzN
	1y+6/ZZnKyZ62+pPM/DEC4Iylg8Krq0wAPqD6KdtuGk+Zdk4DKUeyMhiXbzJYdVL
	bIj/QJM7hN5BtusgbHD8m9xNThogT6wHKhQIkdOp/hbQypKE27fZgHchGeO+1BTT
	VPUpeh/bBZI59ScXYRgw65wzTgoMMnoJmFsZzRgRsYFyWaGGYCwKpfq4lPUztwV7
	wVHDf06/SCOxR42J2Z9vbHr4UhAdTAjtbJeXNkQiLE7+wIkknP7olxo/NEw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68jytkvp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 19:43:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88e0d11a3fso661425a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107807; x=1783712607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bn4n8Ensq4b2jWU5voHmUQF7/CVhT1UW+T0M+N3rGrg=;
        b=ApQqXwOAcO4+/FgwfmKxprPwR84H+OKPDdPpdx2K9PuHKg4KEmb8TZNaYKrP7lCr7c
         mLd1r0o5V3ImM7a5xnHOix2GlEe+tyN7MWQYZfmvZyjkpAptFkVwrp8xcBe15NQV69Xp
         cYKqqqtFiKG5BvuFofBmxTFAEVdj0n+T8jyQKxBGiZRLwk3iUwCBZUf369z0vd95qNLt
         T5g+za4Aap63Q6gA10TaR+z3VeNyEoj7CZLmRFjgNjgc+39T1Ky9vBL/mWJ12ycySHNR
         osUg0O3MKOFzuW0FA8/JlJcHVL30b/J3ql1eRiPm8+u5b4zR18u2ppJmRQywIgr5K2EB
         ZCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107807; x=1783712607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bn4n8Ensq4b2jWU5voHmUQF7/CVhT1UW+T0M+N3rGrg=;
        b=SVvNOaO9xXs6ytxMGVpAUMV26Vpbhy9ZxQsIuLrpkLdqOAJ27KjCJKYMYmrIbwjokH
         KVZrlw1HwqlikWAupehqfv9C3APeL3QSplq+fXNSq6eSLVLJsBAu2HqH1v20OaNGeEzv
         KZQDxijITrFZ9EqdJP0mPmDXWkLpsVxx+m5CV51IGsiHlOtRpsqK5uRRfjNGpyf6y4A9
         xi+EVeiuB3HcZpawLZgMvqDCCq2rqyHX96UpmDI/6RcnWUCiXeF7/Rdpg3SAnPV/HjtH
         SHObJRyTKkIWQX1BO37XOBolk4vVONof/gTI3nZAXsflfrwDXElXUC/ZQjbfd4xtmQuf
         lRpg==
X-Forwarded-Encrypted: i=1; AHgh+RpDL/29G8QyZpD9o8nHPfw8I6IXOmi4wQ8mUuCMRKyNKgSLEtAt3OH5xndyoENUJ8JyO7lZ7YwTIUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKD2eT2T0SrmpEmyQhKgUZqDPtLv8OFBBRGA3X4caAnNKP0Cw
	uUv/8RsuJU7BRd5BQWI88Z980WvguPIgiyrG0on/kwjGy8+TiFwMY2Q3x62DNJaZgFcXsLKu5hr
	smfi5/TULxDzY4EXpsyAHUH9tZ91y2yE1O1CXYjVri+oZ/X8e72vYv63vSAToVc4=
X-Gm-Gg: AfdE7cnL6jE7m0NTUnFkrg3t0eP6q1EsDteQlsc76Dx4pGpxiXepSxJ1EnXw0UGS+3A
	9UTxfEdG0FD4tePpEWW2qkCajf8dLp8eFpxcfDBdemeHGmdxNosTtwYhB9qJ/dIncYa9vUvekUq
	32wwcmifv/A6Qno6wHJFvCpJdBTeXtYq95EA8Ju5ShczlbhRPCA9eB5Eq9MnOc/EYHd3Mt0k1Rg
	iJr6gSmvRDWuaMVSUwrefPbq+xkjNuY11FLAc7IxeQ9nBeoZyUo15/q/w0FFhGVXOmWCUNCf77a
	dFZdx5AGh66OSBuOMhk15C1OewHm3MYIZ738ZpoEHm1sbaK4m+I8lafICrssM+HvZ0FuKBMC6qB
	alAXg3rZ2fzyjjw8Zheuuiief0Lw+5Ch1AYlSYA==
X-Received: by 2002:a17:90b:48c6:b0:37e:2005:6507 with SMTP id 98e67ed59e1d1-38280e98cfamr773056a91.15.1783107806472;
        Fri, 03 Jul 2026 12:43:26 -0700 (PDT)
X-Received: by 2002:a17:90b:48c6:b0:37e:2005:6507 with SMTP id 98e67ed59e1d1-38280e98cfamr772970a91.15.1783107805852;
        Fri, 03 Jul 2026 12:43:25 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:43:25 -0700 (PDT)
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
Subject: [PATCH 10/42] drm: pl111: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:23 +0530
Message-ID: <20260703193855.110619-11-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX/FCz7oxyIApx
 H+2SW8LXJ0ZT7jS1zhtL/7mZXM78POxIWVx6WbV3kT+Gw0E/XNq/3ACUkkKWYohMq8FfgzZAw8U
 ywh9pitpbcD5pwyL6/+LFawQA3EE1MkUoC6ZCdpvKlQEU7q3QnH+y4tX1/t6ipQdY1DRxxvD7Cw
 47WYfjmIck5kq92c9JEjiLCi6UpJZUKbRlo95ep5YpHCRBF8mho4GMACM8QliD2cZ+bmhfS7bVw
 8u60R8lnTFNwrhy1go87OgdHrmfztJ9NOCuYl1D3OQ3h3HMHFPEDH1fmJXzg8YBjGCvwnwpV+yW
 KUGhC7yONxQZILn+dFQ86PrUlV2GXhV555jXW/3njDtt+d7zn6ip0IDkzXoKppCDEk8DrYrbTNp
 ZHyibXPIXA64mVKAqq+4qdWYK0D32D3bsYeBvSluOJEXqAVXDw8tQBdFzxKF26bSy+FkiQKI1zy
 lAjg7ifYeqk9Ei1HEbA==
X-Proofpoint-GUID: M3JjTQ6nfuidXDsJNrid8hJtM_pUOxFR
X-Authority-Analysis: v=2.4 cv=QbFWeMbv c=1 sm=1 tr=0 ts=6a4810df cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=ih0ztwYHz3j8HjU85xEA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: M3JjTQ6nfuidXDsJNrid8hJtM_pUOxFR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfXzavi1Gx4U9oT
 hIytXgWElKS7yBGcVVAVjcimLCPu5oYZ0fxZMhGUK+MdafnY4Wm6Ek/w45h96ipurIVcbxBm/0g
 hxrjdgjaxTG2JDfcmhcJqnl/buv06t0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030199

Switch to devm_of_reserved_mem_device_init() so the reserved memory
region is released automatically on probe failure or device removal.
Remove the explicit of_reserved_mem_device_release() calls in the
dev_put error path and pl111_amba_remove().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/pl111/pl111_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index ac7b1d12a0f5..25ce37a4e8bf 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -254,7 +254,7 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	drm->dev_private = priv;
 	priv->variant = variant;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (!ret) {
 		drm_info(drm, "using device-specific reserved memory\n");
 		priv->use_device_memory = true;
@@ -313,7 +313,6 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 
 dev_put:
 	drm_dev_put(drm);
-	of_reserved_mem_device_release(dev);
 
 	return ret;
 }
@@ -329,7 +328,6 @@ static void pl111_amba_remove(struct amba_device *amba_dev)
 	if (priv->panel)
 		drm_panel_bridge_remove(priv->bridge);
 	drm_dev_put(drm);
-	of_reserved_mem_device_release(dev);
 }
 
 static void pl111_amba_shutdown(struct amba_device *amba_dev)
-- 
2.53.0

