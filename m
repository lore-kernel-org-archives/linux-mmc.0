Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8DF3B786;
	Fri, 10 Nov 2023 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yspVliIE"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E771344B3;
	Fri, 10 Nov 2023 12:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1699647268; x=1731183268;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3tVJsMHXywNdu/lxHtHGdXO/ugKIDxyuytYpSVUfKts=;
  b=yspVliIEvC72nf4ymJFr8xgS/GAWLOuvkFBgoHVOi30hgX1Nt4uysqv5
   Irf6T8MKuOONJvZa96PMFaQ1kw+PyHubwbZgXX9Lt6r6VRS1MBJnCGbHC
   mSgcS3P/fJShA/RoAuXU9FQSGK3obrFFg06TQgwjS5B8wDy2inpiq67V3
   SMQlTkNLkpDk+q4hF4m64s2qFkRTQrzgsyMuJ96crS+19mOnsnNG/2eBE
   X2yNwFJeRbWDEYoL5YpAlNiQQbBq5KfLhrg4k5INjO8WH3APYsZFtKta0
   0oeKnBcRQDOLc7NBdNJtiE2rsYkRj6o8G2OXnHSP2+VKESjJjASdJ7Lub
   Q==;
X-CSE-ConnectionGUID: 0pnlH8zCQBubqT4ZdDxfxw==
X-CSE-MsgGUID: AfSEwpGkSOCGbhn+rfs0fA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="11796744"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2023 13:14:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Nov 2023 13:13:46 -0700
Received: from [10.171.248.20] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 10 Nov 2023 13:13:44 -0700
Message-ID: <4d505dd3-b289-4191-95f2-4a6eaa647e81@microchip.com>
Date: Fri, 10 Nov 2023 21:13:43 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: atmel-mci: Use common error handling code in
 atmci_of_init()
Content-Language: en-US, fr
To: Markus Elfring <Markus.Elfring@web.de>, Julia Lawall
	<Julia.Lawall@inria.fr>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	<linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kernel-janitors@vger.kernel.org>
CC: <cocci@inria.fr>, LKML <linux-kernel@vger.kernel.org>
References: <c70c100a-ebfd-442e-875f-738593faf0dc@web.de>
From: Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <c70c100a-ebfd-442e-875f-738593faf0dc@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2023 16:50, Markus Elfring wrote:
> Add a jump target so that a bit of exception handling can be better
> reused at the end of this function.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Aubin Constans <aubin.constans@microchip.com>

> ---
>   drivers/mmc/host/atmel-mci.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index dba826db739a..1e83119d1dcb 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -675,10 +675,9 @@ atmci_of_init(struct platform_device *pdev)
>                                                "cd", GPIOD_IN, "cd-gpios");
>                  err = PTR_ERR_OR_ZERO(pdata->slot[slot_id].detect_pin);
>                  if (err) {
> -                       if (err != -ENOENT) {
> -                               of_node_put(cnp);
> -                               return ERR_PTR(err);
> -                       }
> +                       if (err != -ENOENT)
> +                               goto put_node;
> +
>                          pdata->slot[slot_id].detect_pin = NULL;
>                  }
> 
> @@ -690,15 +689,18 @@ atmci_of_init(struct platform_device *pdev)
>                                                "wp", GPIOD_IN, "wp-gpios");
>                  err = PTR_ERR_OR_ZERO(pdata->slot[slot_id].wp_pin);
>                  if (err) {
> -                       if (err != -ENOENT) {
> -                               of_node_put(cnp);
> -                               return ERR_PTR(err);
> -                       }
> +                       if (err != -ENOENT)
> +                               goto put_node;
> +
>                          pdata->slot[slot_id].wp_pin = NULL;
>                  }
>          }
> 
>          return pdata;
> +
> +put_node:
> +       of_node_put(cnp);
> +       return ERR_PTR(err);
>   }
>   #else /* CONFIG_OF */
>   static inline struct mci_platform_data*
> --
> 2.42.0
> 

Best regards,
Aubin
