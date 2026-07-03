Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0765342538
	for <linux-mmc@vger.kernel.org>; Fri,  3 Jul 2026 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783108223; cv=none; b=dSdBFygqUZnzPQpwOflcAhgJrg2yBMQSi0M+pbPiCghs+JLFaF4Z6JGqARJtsJQ7OATRvWyyxFoSmi8eTnj5QcFNEvXgIS74rmfen5Z983TyvBGWkmz9QzUlTRq5y5ZplwnMmPeJ5shMX+in91xaepAFYRbk+yK9MEpu+3Z6Nd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783108223; c=relaxed/simple;
	bh=FTKbh1PfTzKc4u6Y9eworjSSUrythSL5GbM/EdgLv7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVEcpu4OzkZKl6Zl8+Xli0x8SKCnyyryOe7Yj+LXoi7TxmawGVN7GFc5Z9jf/rWjPzBAs4z+bf1pzV5Jc9WzuaB836HAsy/ZHKMGKWL9UUpnlDfTcKNKiNZRkqjWcn0FlOSGeZ8mgnEHGq+9a7tDz3YLt0Os8bGaWYc1cskg6cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G9SC3rEj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eZVpm508; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G9SC3rEj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eZVpm508"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiX5Y662857
	for <linux-mmc@vger.kernel.org>; Fri, 3 Jul 2026 19:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yRi/WTO9ulM
	C6lVt6c63wlpnlLgzkshb40+LVJZvO7Y=; b=G9SC3rEj2kHAWnYiSRqHCTjG60U
	GTp1/0e6hpptCvjyg0JEHGriBBim0bhbPooY0oATfxtcRJooXMhaIcLDCcBqjgxk
	jYlGgrqHqhqtatabxhhxjtMkbHboHxz/yXfKfl759vZd1PEzqNEIW0l0ix6uYNAI
	Z3aEDzbTEup8FZLMCo/qecqk1uNB3pqgFiIPsHh56TqHtkt+ROAaE4LsRtNvey0t
	g+6LF+M75t44gZnCpER4kEMf1DlU9CKiCvGgikFnVCvCdxrVPZwvpgNo09p87uYJ
	HY116V/TYlyPgw62giiMSUYvclGNTfzHx3Sk7c46X48NmxcNE5oOV8dAUYg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eycfw4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 19:50:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca124bf0189so220950a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 12:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783108220; x=1783713020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRi/WTO9ulMC6lVt6c63wlpnlLgzkshb40+LVJZvO7Y=;
        b=eZVpm508ZGfDYZg2I6In84PDki5oWovp8WnIUCGMHb0sO5xbbLh3BvkdNvKTtHgJ0x
         8bfBLTW7TtOolwjYMQ9hO0NCCepfegNNnY8ReQrVtkQbYWWa9gav1AIRD/9V3f+pUm7I
         4C8hUZ/7WgPBAIxXM5D1VE3MRWMkKU/tPXob2efhzEFp5WTaA2bETIPcY4/sJl28qLoo
         gLVuVhJCgb+fTlTY7Q2QaOHoM/E7rWFgPFeEg4utRJs53PYdmm4NlOFBwN6TPi7cWjhg
         23qR0ptdRbRHUuiKGtLU975yRSKSm+QHKTp4Zjv1Rm71i4afaOoGd6KVYRgPshMu9sbO
         b1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783108220; x=1783713020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRi/WTO9ulMC6lVt6c63wlpnlLgzkshb40+LVJZvO7Y=;
        b=IW4iA5vNzJFFEY1xn+1WU5kaUND1UMyGZwN4srMdQvM/CNivGyiDuQ4i/kCR0nLUfu
         ZeM3lY1Afv6XMn4qGyn8MN3M9ZaczhvllRwzXDQjT9OxSmCmB+Ipnj7UImSMXLug3ym6
         PCkluABjIG8DJlPsaamV7OG3LzmVsE+DUiKBTDTtCZ5aYTKrn6Z+iZn7qT8q1X1tpPTM
         tpAu/UJda01nb8oCep5BxL2a3vKigxzGOCOq+CkwNQgOkXyClzIzdDCSnsT7vQrjwgkJ
         3HxMhasEsnniwugTAv3SiC/wPiaU97YOI4pxyu6M5kIUkrGHk/rhCZ0T4EhBZZ5z/4OX
         hoag==
X-Forwarded-Encrypted: i=1; AFNElJ+fU+B8VaXZ1UJq4kbCvzxC0Tspp8hR036L6mQJIVD51Ks/iVeOTHQqHLWUxjznHXKUxt2yFSvSRMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8Q3XLY9Li2Fh/oPHWzyOgoyyclptUHnXyJYvk9Cl6mJmU4L0
	jDdzQL8dMLi3p4/QkWO1P+5qFZQ7Nk7WrOreDbf6rtGAfiqC8vn9YVh6hqQFiSeuDEAsptIxK07
	iDq9UiiZKzoESDdF/Amgn8/RNRi1QEU8gvk1nRZWunhJXQlwD58k/bb/luriVVPo=
X-Gm-Gg: AfdE7ckwGrIhlMK1pRmU8jXEV8BzlsLFpntfDYs0mGKQf8YnLgjkRttoN6cIWN8uS8K
	E2CguYSkqm4IpzX9o1izRQyCuzexIo3FkEfmvxXdrXiw+Y7DHA48touxb0V6hBej5/YZ7I+Y84O
	IIuGHN6O78nJ0CAgnyIYCZ3oSYVdoTA1iS6+DgYocJyudB1IVwgEu68MxkZmlwiyBBER3qNYrRG
	7tObTPjyBP024Q7k0nrZYRTrN2kfvDa+a42O7BhHoM0PYigKT2KYDFv/ceL8rOu9RL/nRO1JnL6
	dvhQUQhBoQP5S0xk2dp1i6dHvEuSIZwlHbEW3+ct+SdVd4jB1e1PNJ986wPhPmsSI7a+Uy4k0K5
	nMUwkjZvygsn/Il6kAEOLzeoW2+iU5CI1W6q4PQ==
X-Received: by 2002:a05:6a20:938e:b0:3bf:a8fa:a7b1 with SMTP id adf61e73a8af0-3c01cbe495dmr6288402637.37.1783108219256;
        Fri, 03 Jul 2026 12:50:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:938e:b0:3bf:a8fa:a7b1 with SMTP id adf61e73a8af0-3c01cbe495dmr6288369637.37.1783108218631;
        Fri, 03 Jul 2026 12:50:18 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:50:18 -0700 (PDT)
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
Subject: [PATCH 27/42] ASoC: mediatek: mt8183: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:40 +0530
Message-ID: <20260703193855.110619-28-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfXzBn5MbfbNWdZ
 34e7gxFtkFEVZr9tbQCzWSdFDssfjLPyvbTZEwbKaCVw8GekecwuQvIT6hqD/iFuzYHNiZ87nf3
 EfEsouS4yMYA0kU8untuFBE4wmUHVIj9wVoUDCKM8S0GChDSMZ9GNuE49PnQwtel41p9d4pQXFS
 GxVTLwpBUUNpgRP2W+hK+CRDN8bda9VRn5zXDh8gTxSvwekvG37FwcQksq8fjI1QZGmUrdKiwk/
 pSqlqGXeAvwdmrtmVGZF4aODw3+/OHYYy122bXLC+gPPgycG8ujV+BBLR1rMlKQgrea47CiTR0t
 czUdmZl9f9v9oji+iBYW8BKK0xGia4dWcoN2FkMe3ame1ywBMiNEhDDuAimpJyYngqfSffvLaGo
 VpEZ8j+Oej4IhOzHQJWUUtu+130GGnpN9qOFq/8ncmDAPy3juLs9du2UWFOa7uYlLGJRsBvEtfj
 3mNEUErVwPC9gvUFhEQ==
X-Proofpoint-GUID: DRtcrtZK5lIMfE7rIICFyM9PrhbccjXD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfX8+bWmyxwdRxm
 x0I2nQAMNZa/unxx9m208EWyNQJkmCorAM033qONsGcPWSdjV7y0QlbBP4Rb9wKjLBRJUSWvh52
 RPL8CwQeoLVQ2V2stLBJ/yNylFLfi/w=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a48127c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=5_2tDv0Uws32Dsz64S0A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: DRtcrtZK5lIMfE7rIICFyM9PrhbccjXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030200

Replace the hand-rolled devm wrapper (mt8183_afe_release_reserved_mem +
devm_add_action_or_reset) with the standard
devm_of_reserved_mem_device_init(), letting the device resource manager
handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 2634699534db..6ad396e3b10d 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -766,11 +766,6 @@ static const dai_register_cb dai_register_cbs[] = {
 	mt8183_dai_memif_register,
 };
 
-static void mt8183_afe_release_reserved_mem(void *data)
-{
-	of_reserved_mem_device_release(data);
-}
-
 static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct mtk_base_afe *afe;
@@ -795,16 +790,10 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe_priv = afe->platform_priv;
 	afe->dev = dev;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret) {
 		dev_info(dev, "no reserved memory found, pre-allocating buffers instead\n");
 		afe->preallocate_buffers = true;
-	} else {
-		ret = devm_add_action_or_reset(dev,
-					       mt8183_afe_release_reserved_mem,
-					       dev);
-		if (ret)
-			return ret;
 	}
 
 	/* initial audio related clock */
-- 
2.53.0

