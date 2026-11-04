Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816303;
	b=Xkao3fVjKrOsGTkzKOgPyekN3h17NokYAoZb0IPUQbc0OjS4XFN40uP5UTGtW8fimuxk
	 HgCyGsarbFL0dLkpbJR77N4NfgvzcYJlbIDC7mP1yvBzXvzfwQuKvg4DASTTQbyC7okrf
	 AZUzob6VfDnpUrU3RT0KJxS6iQYEmWwkw6yJCOek8yX/l59cxDI7/tqwIK78/NfaLc2n5
	 2vmeL5F35upMqkGrnzoOrZTUQNMq04aATNAy9e5xFB8gh+7gS/+k8YIYyDyj0jgH61hTm
	 G5lTXmWunth5WxJAXxaW7Ryjtn25hH56WEPwYOBXtwcNXrTNCIjuDzegWNPl//iTZxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816303;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=sMF+DuUShxHT93jwpB/tWUFXCy+FZ5GF579riWa0i/s=;
	b=uBLE3WCBFro/td5OpTRdlHit5d2hX3xg78rzhA7ZxVcgu/w2OkAQ2Qa3nXPXnB9KPGJd
	 YRNsqNAOo7yE+VKJgIcgfNDk7tkdsO08R7O1Ql4noHnrxE9KLKJlZNby2ZgyFIiq4RwTm
	 zHQoQHjtTVJqy3SmG2bOolvMB5oIgrU+q8ukS2zQKSWZTGykOpRSQGSvUovHt9mzj0K5+
	 +MU1xdanIMtFNOk6hQ676a2P1CGY+z+DVlapT5Gv7hLr47mJawjBELwB/DeA4LKKUHtjR
	 91RcZ/pLy94Z+kgixACOJA9GMg1QcISn+Wd1Cup/weQ0ZpDz4Zy8QF5A3WSA9sZz+ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RGtOPZQX;
	arc=none smtp.remote-ip=209.85.160.227
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A94C606A328
	for <linux-mmc@vger.kernel.org>; Wed,  4 Nov 2026 18:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A94C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RGtOPZQX
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-53653e30353so12374091cf.2
        for <linux-mmc@vger.kernel.org>; Wed, 04 Nov 2026 10:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816302; x=1794421102;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sMF+DuUShxHT93jwpB/tWUFXCy+FZ5GF579riWa0i/s=;
        b=iic6A+mwJLq50OILUdgJCHwyxzeHnqcomY0dqRy6PybHs/IVOq5SxsQ8RfvXSry2DL
         vFxcQ/IljBMjJPinNnyqvo1Y7JgdZsc/zsarsDU1W9YUTeeviwnJpyq7S2lEfyJBb57s
         +k0kfgvLYXVOYBHaocmB2vDHCVsh68WvqG6xtIQPBuDnaFBs1XHjXeXLxxHqanGeGB1B
         llzGIrZSfWV8vPgvwLa1Jq3KcmBkFDvD8zH8soa2K6ecEHGRmERSoqc64KC5UQZR1HG+
         hp31NvWpbN/lpB6aGPNYZE2IIHWDFYEwtOVhkUVc4iJk7r/0eaYduKyEhRFADWR/izJB
         /Bbw==
X-Forwarded-Encrypted: i=1; AKwUvBwA4xmTFfUXUCq3w1EfoQ4DsfcW2A7UEZ4qP1ojBSuEJcIXmGLGSncLQM8Lf79iCrYHcPoyn3gwzhk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ovHX80uJE3CRMcp9y472w1owcdMCVyofPOpD0cSlFk27VgxPw
	7myyGI1TvxRQYYuTsJrLBWCvYq95bL8dg6yD6l4oFKJkVU/s/GlMcRFTi6h4ju1JR5Bkd1ttqx6
	yYTRWkHQK2eveJ0NL9zsbVcP/OdhdLG+pbkWJUvf61h5sfUdQjJyG3g3qgRctLbniLwBeuKqIW3
	g7ttXyjB7geGflVXldlNZq987/9/8IUuyNf6DgUGlxZpZF6uHU6VVvsxJA7bUR/edE+it15k+b1
	a2780FOE9RRWvuV+mYEaxA=
X-Gm-Gg: AYBFou0jg2RLcL8VDIiySswvCKXhZMAPzndad6XFCvasYHKIGjImkd23fe48oiiYXjZ
	l+ICCJJIf5yxQeBBuSYvY64XBrzYvpm5R378GUDCrruZa7UH65CeO7cVhf1ZaDty22Vewrvx1oq
	Q6VJtDEHEf/XDEU504nDcek3TV7B/+bswz4qxTN2YUJCgy+vw3GAQM/qn8oD2p04M1ggmt02nSs
	OkBbQrW9TGJlqVRmEsHGsNvTe5/y4ppzJBGNpljDXsw4PzFtGw6qWir+S+jljsFghMBYypKZ1OT
	uNbv8Tl3NBJvGLnebbcgPmZDUV1Whd2ltKG6vml0zcoK4ITvgQa83SaL99U1OiA1nd2Rj7aAkCt
	n+f2+Gc9cMllIfhAP3S4ceVKJyoXEea0+FCyqx0z3kzjYhou7/DPwYMKME8A6cpraxPolnOe4GZ
	ISkJgXMeCd0+tH3i9PylNyGn9S+TcPQ2NEgtFYRjUh
X-Received: by 2002:a05:622a:30c:b0:537:af99:b562 with SMTP id d75a77b69052e-542b742ceabmr263157561cf.47.1793816301977;
        Wed, 04 Nov 2026 10:18:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-54b10c4e4c1sm305611cf.57.2026.11.04.10.18.21
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2026 10:18:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91c85c9a756so23621506d6.0
        for <linux-mmc@vger.kernel.org>; Wed, 04 Nov 2026 10:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793816301; x=1794421101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sMF+DuUShxHT93jwpB/tWUFXCy+FZ5GF579riWa0i/s=;
        b=RGtOPZQX2Fz9ek0gpNC2zgdSYq0yoKjSv8q/M235QDrvAkXxkbXEdhlbwDUlUp5lun
         FSoUAU25te5vS5o4D349NuR7vfytBFx+k5DOluRTFkT54TjpfElzU2eKd5fMbCHOTvUC
         le9+1vSf+Sr/FhjCDRjA5yTQEiXnEugu5V4BY=
X-Forwarded-Encrypted: i=1; AKwUvBx2aJ/zMrcbAJ21tqFbBmAXHMr/jPPXh6A/MVRLtXb17Og2QZGsd12CzJS/LrIHQsFNHN+IpihIaBk=@vger.kernel.org
X-Received: by 2002:a05:6214:5781:b0:91e:8baa:f132 with SMTP id 6a1803df08f44-91e8bab0503mr27359926d6.14.1793816300869;
        Wed, 04 Nov 2026 10:18:20 -0800 (PST)
X-Received: by 2002:a05:6214:5781:b0:91e:8baa:f132 with SMTP id 6a1803df08f44-91e8bab0503mr27359016d6.14.1793816300171;
        Wed, 04 Nov 2026 10:18:20 -0800 (PST)
Received: from [10.14.197.69] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e8dac2a3esm9677426d6.1.2026.11.04.10.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 10:18:19 -0800 (PST)
Message-ID: <c5ecea1e-ae30-4df3-8684-39cfb8288127@broadcom.com>
Date: Wed, 4 Nov 2026 10:18:12 -0800
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
To: Frank.Li@oss.nxp.com, Aubin Constans <aubin.constans@microchip.com>,
 Ulf Hansson <ulfh@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
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
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
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
Cc: vkoul@kernel.org
References: <20261102172126.3890568-1-Frank.Li@oss.nxp.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20261102172126.3890568-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/2/2026 9:21 AM, Frank.Li@oss.nxp.com wrote:
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
> ---
>   drivers/mmc/host/atmel-mci.c             | 3 +--
>   drivers/mmc/host/bcm2835.c               | 3 +--

For the above:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

