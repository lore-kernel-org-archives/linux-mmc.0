Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5705642B74B
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688931; cv=pass; b=YV8iDEOxdwesDMIfIf8bLXwunSaTtsSsNutRLJSbaAJPckgF5gQi/i43GdWduwecEOo0R/EG8PxPrJPc9I26lsSVHsHEbCwZgK+2ii1j76o3KhLcs6NGnYrBNbBRIrSOsNiQsYJvsQIW/JUO2M85CIOrMYl/PXz6O9FuotZ/VMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688931; c=relaxed/simple;
	bh=ps29wYiABii6l1raYJPu8jGO+QY9Y08lyWKo6XlwVyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHOPAukRjk600ewArPT+TkMwGC7nnlODqsgZn98Ti8QzebRlXsdt0CziXdhEx4q6iqR7BlNPg7vfgjmPdVQysESJyd8i76tX8FqEb5XGaDpWHdSat+9084V+l/udVc08+zF4So2UqHfTuGQQrsJnboRzshiL8qEwDUdAFgaCa/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PQbhMoe3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E/jXkmeA; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PQbhMoe3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E/jXkmeA"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD6X8B823157
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N5Cka933m4keuHC9q+ty9VLjOYV17gugYbjBnwJv6Bo=; b=PQbhMoe3PoBcb3Hs
	/DihV9aYD7N2odD9vazHqRjsDv89h5rZHGphaH+tpWhsa7+af5rBKTPuJdW8LPZn
	Mk39Wieqo6Mw60r42dLUd2Gxgi7p8bxjZpLshjrj7AzbL34A0DXvPUZmVUH4NX0g
	MgtJWs+BKx0AJ2Ezx5aSRboaeoiSWTe52rVeK8zpfzJ0RAwKpEqAfSYiOKp5qRRf
	EsdJxs0bExnyDS3qhxtop/v2dbSfVm0i9jaV/APL5yQgCnzY8s/Y1+SDeOsMMPGn
	F/+wgSzwHMID5UrcvHdiCAnKRs1pvv9gBeLt9XKdfGXLhg0wmyfSh8mZwn6Udt4N
	ZKZX0A==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjcsak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:08:47 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-662f741fe3bso1177540d50.2
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 06:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783688927; cv=none;
        d=google.com; s=arc-20260327;
        b=Q1FhWwE3S93uX5GE29fRS9ZJAUy6cmyKVJOaNus/1tuehg13uSydH93OrgQeom1L9A
         VJkuFcxfkqkx2Nh0jWj8LLekVr0sAiJy0+VqFi0Du+r2JoBOqGyny9XGzlx9Tvf3pCTn
         blHshxQbCnLoVPE4A3F+Fun2mC+s+FmppIMfIkVyAEhm7D51vyUVYb2vWOONOYXTpaeh
         dtzMteToTFXE6+Gt1Sitb4i5ConMtgK7MkdF8QbpwzgF5FNoN2Hi9DllnwMgQ9/uhhn5
         ULjFYe6d0wyv8lanoN4oi6ODV0UWT9LTSRZIhixSfM+ucWF+SJGvz+xDUWUNzpiJYM6F
         xUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N5Cka933m4keuHC9q+ty9VLjOYV17gugYbjBnwJv6Bo=;
        fh=BGfjLgJQOdZjtWwYVGT+Un4d8qDH31qHu3fCDS0EGQk=;
        b=gLSU50urxpeiT65d17gK3CA2MNrYYmW1p2qdqNNHnnM4TNW83MQyU2ZENboDkLkjQe
         GO747HfQ9+YTjrKUi+aXWNB4Gic2ftbmiyuDFO3V7uBZ68NYA6OiPsT4tOOi3e9wO99J
         bh6/Ds94+DRjb0RJ6uH+cqvDXO91W3/Fut8J+H5HPYjnfSnGMrcG3zqXJ33aZRbjjYxZ
         lg+4AM3Yd9YGNkR2wLvlFgC7LJa0g2Kw+P+chjlJP2nMG6tJJxjb7ivA7Wt4tm0203DB
         YyEJN4Mu++kHgMyI/M9v9rxecHesTTBwk09mY5p1Y+AdPHB+uX+oQlr9lb0pXff2lRNf
         9fBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783688927; x=1784293727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N5Cka933m4keuHC9q+ty9VLjOYV17gugYbjBnwJv6Bo=;
        b=E/jXkmeAELPdpcsB5FAYtysw0V0m75uaNGlZczuE8t6cMDWaLn+c3GD6ANWg+CwEtW
         oBaBOuvxNivvTWWmvf1tECkRUK+La/a0NLK5nfPVbjQXDdcpN7hBe2jL7fb7q17Ux9JL
         4bu3ys+/mel3WOzcQxUtzSRJ3JMD4z6d5fPJ61mkY4d2RSZweS0mfRVMTg8Ig8+TMZYT
         pvANgz+GtJ0d/RM9TGRtUh7vgTSJesuRsd10yesKY77gSXqQPL/vVMvwWYyXzw1/VBwL
         V8EIP6aHxEpRQhAfVje+1FDH4ToWwmtmOm0qFvQ0AyazUGsdC3EKUoqSeQs27tcyJYut
         h1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783688927; x=1784293727;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N5Cka933m4keuHC9q+ty9VLjOYV17gugYbjBnwJv6Bo=;
        b=T9dWToaRVu51y/wsIX+QtGOf+U5JF67sBM1t4eQrPMQBzvogunEeGxjZ3HmYie9YwQ
         WE29Jg9cPYUcmu84zZ9TpBKSNAJLQu1qiUOahIjRBtKW/RsxxHHbhqBGZbVebZroVuoE
         3hYamS4wMkdfZZVo6NUSEKbUHLYw9hk1e+i9Iy9qHNwEGBEGGN++cwUc0YrSly7A6c8/
         x3Oapk1yRM8Tr1xSOh9c2X6kv0LW9/p9EK+1fcg0anI6uNb/pvhk8razaLliZz+EPqrM
         Hrt99SKVOpNvko0XPZbGbqBjLZB2MY3q7ANvd1Fm1bh10tmtIZ9L4x+d8tnuQCK1Pcyp
         EP3g==
X-Forwarded-Encrypted: i=1; AHgh+RoYITeir35pj4a/qJd0co7XE2XUDr6R2NOKrzIY/r2vNnDwehkoHR35ZR9E+24RauqnZE2zdMjRsDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh+rJbnPXHHoCZZpjcycip9ySWl4FurSYOGxbTkqPvR/irKUr1
	yBMxu/v8cdKdI0Y5KRDKtWeJTdIaALgfsPiq4BpruYuuG8g7HhlPiChq+j/ZWO7LUMLhRTIZPRs
	lpVWlVsv6TeVuNSW+1K9XJXOmLjBWthnyULVrT6dRP7e9c0qwy9ir27h5LC7peh+WB0TqM7i+8Q
	ei2zN8PuJWjIhzzukR7dqEEFtW0/xhRPlNthgFDw==
X-Gm-Gg: AfdE7cnt6BZf5Wh7Oe5ggbvRDq1MoJhU4DVGGCNa5i1LJxmrROzrRvmDZhhonlb26yH
	nvgnNhKsgMCkyD4ewwPCfyM5SbPBuaikLsGRZZYbcLZrl9oH22p/4HCZlMkjEARxzsLyxEAskXx
	ApVq56wS0Ai3fBV1bjwrhWtsC+XDOvu8T5IicE1bkIz7KSpgNth8NO44GrBBSkDRLQiuCP
X-Received: by 2002:a53:bd08:0:b0:667:8b91:242d with SMTP id 956f58d0204a3-6679f245672mr5946038d50.92.1783688927301;
        Fri, 10 Jul 2026 06:08:47 -0700 (PDT)
X-Received: by 2002:a53:bd08:0:b0:667:8b91:242d with SMTP id
 956f58d0204a3-6679f245672mr5945969d50.92.1783688926691; Fri, 10 Jul 2026
 06:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com> <20260703193855.110619-24-mukesh.ojha@oss.qualcomm.com>
In-Reply-To: <20260703193855.110619-24-mukesh.ojha@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:08:34 +0200
X-Gm-Features: AVVi8CefhojPUiWasaXCCjZmJBb6K9Qzlv92c3u5BPoEMYadIduP2fyzpl9La3Q
Message-ID: <CAPx+jO-hkYQoEOj1Jrp7sn5HXYTDbfAG4U5rpNBW2Wue2TZxhQ@mail.gmail.com>
Subject: Re: [PATCH 23/42] mmc: sdhci-of-bst: Use devm_of_reserved_mem_device_init_by_idx()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
        Fugang Duan <fugang.duan@cixtech.com>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
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
        imx@lists.linux.dev, sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzMCBTYWx0ZWRfX1LIw8kMhplPM
 bFCL6LXH6ST7JCxGkd0A18Jz8cv5foq4OFji3f1o73HdS+ZZ6XIk5uBKxHrKaUdJG0Tsd38E36R
 x4rE7BnaXqT8Yd7DPt9RYHD9PqZe2xISQ5WRsaKtrby8Vv3epKHJHXK+YC1WdBrrqV53LCE+Sc/
 95jMfwS1nkCbuemxNCcYTyUMFRLRkn3SYJ1NKKjA5rqLqEz9S29g2W8u4WyJXX5pbA322Ig8Ya1
 s/Gx1jJ6mZpPlWLIv2mFXRv61FPqpgRmKYp7nnXW09uFYE39eE7VOeGogwyMNfrqvrQkgm4f3ON
 6XuSphOmAMK3ddGdkGKFZxo9ELiLbYhAnKX/IYRNzYAxjwYLuputwuxEONfSZY8YfConSLWih22
 zN6mtkdozne1zJlP8BYSqcAZ3yj66wm0pAY5enuywBmzAC0OMg1qIN4J0iQaGzGBDgpfLIJ+VCv
 bc5pRv9pj+6YNAm6Ibw==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a50eedf cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=z_eSG8vRrt57AjWXvbkA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-GUID: jhi7OSaIUv6_fog8y9W1ydlR3abpeRZs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzMCBTYWx0ZWRfX5vKu+WVn0HJD
 jFFWo1L867LjAx0afIXBq6e17OJhXTwh8vbqN+UWevsutYf+mfZQMkL+o4SCYV2JEqC+vjl+akJ
 CBaL4dVXWyBPTolMVmwWBJ4SWQgA3ho=
X-Proofpoint-ORIG-GUID: jhi7OSaIUv6_fog8y9W1ydlR3abpeRZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100130

On Fri, Jul 3, 2026 at 9:48=E2=80=AFPM Mukesh Ojha <mukesh.ojha@oss.qualcom=
m.com> wrote:
>
> Use the devres-managed devm_of_reserved_mem_device_init_by_idx() instead
> of the manual of_reserved_mem_device_init_by_idx()/
> of_reserved_mem_device_release() pair, letting the device resource
> manager handle cleanup automatically.
>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-bst.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-bst.c b/drivers/mmc/host/sdhci-of-=
bst.c
> index f8d3df715e1a..304554ced690 100644
> --- a/drivers/mmc/host/sdhci-of-bst.c
> +++ b/drivers/mmc/host/sdhci-of-bst.c
> @@ -405,7 +405,6 @@ static void sdhci_bst_free_bounce_buffer(struct sdhci=
_host *host)
>                                   host->bounce_buffer, host->bounce_addr)=
;
>                 host->bounce_buffer =3D NULL;
>         }
> -       of_reserved_mem_device_release(mmc_dev(host->mmc));
>  }
>
>  static int sdhci_bst_alloc_bounce_buffer(struct sdhci_host *host)
> @@ -417,7 +416,7 @@ static int sdhci_bst_alloc_bounce_buffer(struct sdhci=
_host *host)
>         /* Fixed SRAM bounce size to 32KB: verified config under 32-bit D=
MA addressing limit */
>         bounce_size =3D SZ_32K;
>
> -       ret =3D of_reserved_mem_device_init_by_idx(mmc_dev(mmc), mmc_dev(=
mmc)->of_node, 0);
> +       ret =3D devm_of_reserved_mem_device_init_by_idx(mmc_dev(mmc), mmc=
_dev(mmc)->of_node, 0);
>         if (ret) {
>                 dev_err(mmc_dev(mmc), "Failed to initialize reserved memo=
ry\n");
>                 return ret;
> @@ -425,10 +424,8 @@ static int sdhci_bst_alloc_bounce_buffer(struct sdhc=
i_host *host)
>
>         host->bounce_buffer =3D dma_alloc_coherent(mmc_dev(mmc), bounce_s=
ize,
>                                                  &host->bounce_addr, GFP_=
KERNEL);
> -       if (!host->bounce_buffer) {
> -               of_reserved_mem_device_release(mmc_dev(mmc));
> +       if (!host->bounce_buffer)
>                 return -ENOMEM;
> -       }
>
>         host->bounce_buffer_size =3D bounce_size;
>
> --
> 2.53.0
>
