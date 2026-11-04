Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.248.49.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757524;
	b=patPR/cW5MLSdnMnc+WIrA+n3ydefs1ebg8D7egwC10SWif/6DsnrFNHyF4OeA7CV6U2
	 rk/bjkZ9vVoucLKmbBVh5i8BK1rmQORmiDdsK136gdQILmPExEtIuNb5ZLueW13kvfnly
	 qp8OFO6f8cJ3+piRJJEGTRzZ/7G8WFcN5AEzrb9B4NXLB7MaYcxrrxrf3vqD7d2hIPAjw
	 ry8J91dJk5eoyRqVYBF37Ds4UbI68JoNkToRpJZ5kvl9dOwky1ZeAjo+4ZzwWyeEd6fuA
	 f0BMLw1wVKZNYtCP9fW+XkHyeqNj9UROkzdGypa5dB0Symc9JZmvXVn2koioWVbwvew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757524;
	h=DMARC-Filter:X-CSE-ConnectionGUID:X-CSE-MsgGUID:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XS2nYBAzLCH+inOf8OGB6kdMPv3r2GGidxq0NzQ4cJk=;
	b=CrUv0RgYIY/wA1Tf1rntIfDb9HR0gNT0wqBQzac2n2+MSQg/4AcIybDD/pE9ELW09ChS
	 6o1YlVUZqOyJ3xFQ8HmELzSF2v8wx5x/NYmjmeVJcTicsH9uFikmcH3QM8ieE/y9/gzCm
	 m9XqGtXxDEgmk3mRZOP8ixjojyvwyauCCLbY3s63IZsAOZCbg8mdxWJE1DULAT3HkM1fy
	 rVLuC0nAQQwC/10hiXLFTqMem4N0FI4uWk0qhVO9YcIrC8qWnsoF5IREc8RO4yOzL4jcX
	 Id1udqio6nr86teKLdEhSqcddUUy6bXCmfo7dFut+dZmqsn3YuwzWqpPJo2slbOugkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=socionext.com;
	spf=pass smtp.mailfrom=socionext.com;
	arc=none smtp.remote-ip=202.248.49.38
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E1A606A328;
	Wed,  4 Nov 2026 01:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2E1A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
X-CSE-ConnectionGUID: 3B2EypkPQeirMGtRpzEbow==
X-CSE-MsgGUID: efgAja9eSgqeIT/hu3a/xw==
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 04 Nov 2026 10:58:42 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id AC36F2094543;
	Wed,  4 Nov 2026 10:58:42 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Wed, 4 Nov 2026 10:58:42 +0900
Received: from [10.212.247.157] (unknown [10.212.247.157])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 6E59210FA4D;
	Wed,  4 Nov 2026 10:58:41 +0900 (JST)
Message-ID: <7d07a2cf-0fa1-4ac9-bdd6-630f44b10a0e@socionext.com>
Date: Wed, 4 Nov 2026 10:58:43 +0900
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mmc: use dmaengine_desc_set_callback()
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, Aubin Constans <aubin.constans@microchip.com>,
 Ulf Hansson <ulfh@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin
 <shawn.lin@rock-chips.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Lars Persson <lars.persson@axis.com>, John Garry <john.garry@linux.dev>,
 Hemanth Selam <hemanth.selam@gmail.com>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Rosen Penev <rosenp@gmail.com>,
 Fan Wu <fanwu01@zju.edu.cn>, Marco Crivellari <marco.crivellari@suse.com>,
 Pan Chuang <panchuang@vivo.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>,
 Rakuram Eswaran <rakuram.e96@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Runyu Xiao <runyu.xiao@seu.edu.cn>,
 "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..."
 <linux-mmc@vger.kernel.org>,
 "moderated list:ARM/Microchip (AT91) SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..."
 <imx@lists.linux.dev>,
 "open list:OMAP MMC SUPPORT" <linux-omap@vger.kernel.org>,
 "moderated list:ARM/ACTIONS SEMI ARCHITECTURE"
 <linux-actions@lists.infradead.org>,
 "open list:TMIO/SDHI MMC DRIVER" <linux-renesas-soc@vger.kernel.org>,
 "open list:ARM/ARTPEC MACHINE SUPPORT" <linux-arm-kernel@axis.com>
References: <20261102172126.3890568-1-Frank.Li@oss.nxp.com>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20261102172126.3890568-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/11/03 2:21, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across MMC host drivers.
> 
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

(snip)

>   drivers/mmc/host/uniphier-sd.c           | 3 +--

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionet.com>

Thank you,

---
Best Regards
Kunihiko Hayashi
