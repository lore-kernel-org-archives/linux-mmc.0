Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C934388C
	for <linux-mmc@vger.kernel.org>; Fri,  3 Jul 2026 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783108344; cv=none; b=tacjZf7X7/YKohqxyVODOOuRWnp20+A6jWMECL1Lu8UhlbNXfRk4wYZnd+DUrFVeGrixxgQF/ABDU6SH0t9URbim5X07sXn7s68fS+tBRP3e9owNRFbWsT5FXu4qNQ6Sj08KT10R56t49m2h7vaae7e8yPZHJTWiGs4GR7LwY3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783108344; c=relaxed/simple;
	bh=b5DaqUyZwpxJhafGz+w2hjXXpbF23SXpR4b1wtVV3dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCBTY4/O7fPgMPUQEHfQ8PQeSX7x6VF7AR3hYHrarsIGigN5ZRb7aHO09DOswrMeZ2TzKPAo5fdizbcb090O43g6OubH5JPW1ggn58yUMcNgaPleh54N/XIRz5KaE+w6lvYSZh2B2QOKHRFAcK6O4428zn7/SyUotl4A5xrNuqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TXRWzJJ2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dcMQ/Sx0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TXRWzJJ2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dcMQ/Sx0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HjA87664148
	for <linux-mmc@vger.kernel.org>; Fri, 3 Jul 2026 19:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DVazRrG0aSx
	Y8WYlC8x0UHgHkIRBJsYN5YFcXqpwEZE=; b=TXRWzJJ2mDiAw8ndD7aCyMTUf3i
	qUwQeZ18wqKRvWYaRG7r+U4Zxk17QhXrKV+uyNMifJqDY+dgJJQUE1PxEVafitbL
	/sq5Mw3Xx8o/4twkp24WyE+09HMdwsGNbm1kb8tfUe4hThZERMz+wvsZtyy92Lwb
	nrBIctgsjjqOJkLu+zd2LD45dyuWrZ/mPnBa/MBW3qg8dEJJgHe+i4VpsMo3vRop
	HEkWuF2pAHHoEiQK1DLWavNEjRrtWZLcXJ1zYzjPtBxzPlLbgbJNPMNInXMxnGEF
	qThiaYPMZK+b3IqAmA49y6rMxQqQcVfei0p5lzYtDgpnoThnuaLpXxDP8BQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eycg50-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 19:52:21 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37fc66ee6a4so1482805a91.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783108339; x=1783713139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVazRrG0aSxY8WYlC8x0UHgHkIRBJsYN5YFcXqpwEZE=;
        b=dcMQ/Sx0vMm0aGeDS2I5FuZKK6U4obveArvfSD8Sa1vGmL1QKKPTYGVte9cH9k56OX
         q+ipeHsJDrScNLQJdrLiuDJLt4VUWD/PEB2WPJ8S3x6BxwrE7bdzvypAvTxqRblM4/+Z
         h9Ww/nYiuLQkHND0Cl9VeKRw73lNXCoZ9lbC0SwLf0BVIz1wPQmUSB+LcC4D5m2C6AAv
         /yHweKMcW0cxNpRsq4Bt1V3237PgTe0Ue5LgQZUqfNS+DXjxgHCVQrX1T+/M9yrYD4W1
         Vyu353ffLEb4A+8vr+yBDhZbh8tm6wqtVW0LU95Hdj3Qv5Rk/2lcE+yjeo/ixDlrLYgv
         Uczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783108339; x=1783713139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DVazRrG0aSxY8WYlC8x0UHgHkIRBJsYN5YFcXqpwEZE=;
        b=DrA5FScDxRW5fHdVYvHZYHGyNhIghiOIvz19+hbWzN8991DWd7oZrvTWl/E6Hv6U5b
         fioZTqPJeJ1gwgcJW1D6tNGhwtPm3XhKvkpto1xQMMNsWHkCMKbGcddzQl7MF3FlxTPH
         RqOcGWCCjIuo3qTU6CAR4dd7nWkcc029oFfN6u52jz+MOPmjCzHUqHLvkQ8Zhk+y/ySJ
         bqkTqEudITYhNKvPGCfAS4vJpYoz9topPk+8f6kMEVoKHU4squzE5uz6ZiHgMRdIhdle
         re0jGEEqMS9csG5m1/BwC/x+l4GGvpVhJ0pZmCeV2BblTkLLVsy7024iXxEWpSkvVZ+m
         5xCg==
X-Forwarded-Encrypted: i=1; AHgh+RpmZnXkMBzSR4QYITAcSOsSJOd5qBUdQ5JU/xpWKDqDyZ0MUJJm4hQCZIhGkDyNPtOcffeXOBT1G3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP0fKL6/pdwuAXwYA9dNtL0Bd+b3uSIUixfPx7ti5rpuna+yTk
	eWYr7kBpSgOsVjdpUlF0PqP94tGwMSY/ng9Rdpx+8AUSld6Qk4ZkM+E05+CzrurPx0PcSuCGmXy
	UVDsRJJlYC7TTNX13iFnkXUGbTDlVHo8Fbis7UFSa4crwptxEnN8WjdoMsyXM6Y8=
X-Gm-Gg: AfdE7cnPxBOZtOOxHd3Y6ZHxnKz+k2H6diOef4iN+JwntTbaXMNX8M5qc1+YPpzvvMK
	7rrDeKR5hEgW4Om9dfp6inK7kyzdQ+qDt/wwNks0qumphbkcmjmjGAErTaIVINaW4fjoML3gapz
	cY+gl06irhH+5iOLElpNt9xt3dpyKvetmZwet+AfXK2wTuzD7tZrEr1hOl3XFOO6h95jOvRH+Cr
	GaKAz28KyPS9kAEK37aGHz0JYRKHgxWkR5+8jC7DmB3qO0gd42ezBfTuhTobBNpVugCgXUZMpmm
	FJuuiUwkqacY5W/jaXybHJELCyxFzdvvpD0kQOUmIm+E1SJBaJQbktazF4Mc6Hv8beAhR0ZZ475
	Q0xRQ7IowXsMgR4TJbXAbdJiOUMBzuDYuBbMoew==
X-Received: by 2002:a17:90b:2d07:b0:37e:1bc4:b6ae with SMTP id 98e67ed59e1d1-382808b20c0mr790755a91.8.1783108339141;
        Fri, 03 Jul 2026 12:52:19 -0700 (PDT)
X-Received: by 2002:a17:90b:2d07:b0:37e:1bc4:b6ae with SMTP id 98e67ed59e1d1-382808b20c0mr790679a91.8.1783108338648;
        Fri, 03 Jul 2026 12:52:18 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:52:18 -0700 (PDT)
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
Subject: [PATCH 32/42] drm: aspeed: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:45 +0530
Message-ID: <20260703193855.110619-33-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfX4d6HPuuuPIc+
 CB0BFiRBnp6thxahuiYNzte7lL5Byi1TkQ6za+gXe8mVvaCe81ar3NA9ZqHI6vWOIk1XcbSnJfU
 GdIcMk29Ec7Tm+7c+mi0p0hEjG1Ql3Pbz87rWRsimqoA28giB1SX1OvpYBGYbzQUZSYW7TAdAZ0
 RCfeBgD3QAbWGP0IMibydJJx7/31LB1WXsjrtu1ytssRAlcwrlMqXUfp/Bcfgpo4DXYZS8k5P7H
 TEE/qCpe6guJ5zCEwIPY/VYsZ6eTWE8MLRHKt7U/lhYYKIeHKRQXS3or2lGRMFT3sXT1LRFxsLN
 9OGPVI91E11hFm7FpF+ZADvnvAykXf3nazjSZYsVKLai9F8lFUm4/F/PRt967sR2zW40Rg365BG
 Ag7M+BEbM56mm3wVNdFT4tZdgTs1LIsJ/w4nV5dFwAsbwT0mUH+D7KdfAGytkE2ne8thTRIWXco
 jjUr33sZFLp5FPX+LaQ==
X-Proofpoint-GUID: ppjdgoZa0b-9o50Yt4lWnPkDmrxTEMkj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfXzIhwJMeHbJ6f
 Vg9brrxrDU5CzxGWHHYggeavb7MK6jiJIjy5xPsfAgSX0InLjwXaAoPP5zHQKDlI/WX2SI7yi+c
 PvNq7UnVhK8+5GTkadal5lC3KbCZ6Gk=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a4812f5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=YxFYfaw6DuWYmsw8bRUA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: ppjdgoZa0b-9o50Yt4lWnPkDmrxTEMkj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030200

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index d4577663a1f0..2c7e54fc35d9 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -168,7 +168,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
 		}
 	}
 
-	ret = of_reserved_mem_device_init(drm->dev);
+	ret = devm_of_reserved_mem_device_init(drm->dev);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"failed to initialize reserved mem: %d\n", ret);
-- 
2.53.0

