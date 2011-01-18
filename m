From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4] dw_mmc: Add Synopsys DesignWare mmc host driver.
Date: Tue, 18 Jan 2011 16:54:58 +0900
Message-ID: <4D354752.3030401@samsung.com>
References: <AANLkTi=0RtvsGX+Q3goL3mdG6oKeNidYtiudTZ8ZTpRP@mail.gmail.com>
 <20101208115510.GD10998@console-pimps.org>
 <AANLkTi=KqOa-MRQiptCtZGvoafRCgULfE3QFs=hmGpdi@mail.gmail.com>
 <AANLkTi=PpTi1_JO9Q=ph7w9Jim8iXMf9LbCfmEkWuo-h@mail.gmail.com>
 <20101209064751.GA21128@void.printf.net>
 <AANLkTimMgrawcndvUTYYjq9BGFqs-sbRsZkwVQ0Uvhvb@mail.gmail.com>
 <20101209160157.GA28586@void.printf.net>
 <AANLkTim3Rj2tTbqvT8nM4L=p=Wx8bdOnGq=EDv+cs02g@mail.gmail.com>
 <20101211192320.GA24430@void.printf.net>
 <AANLkTik7cMwgwXR1zK44HXC+1YtzpU3_zW2GUjcBMi8X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:47136 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab1ARHzt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jan 2011 02:55:49 -0500
In-reply-to: <AANLkTik7cMwgwXR1zK44HXC+1YtzpU3_zW2GUjcBMi8X@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, linux-arm-kernel@lists.infradead.org

Hi Will.

I have some question...i'm testing dw_mmc in our environment.
but i didn't understand pdata->init(?)...what initialize in there?

plz let me know that..

Thanks
Jaehoon Chung

Will Newton wrote:

> +	host->pdev = pdev;
> +	host->pdata = pdata = pdev->dev.platform_data;
> +	if (!pdata || !pdata->init) {
> +		dev_err(&pdev->dev,
> +			"Platform data must supply init function\n");
> +		ret = -ENODEV;
> +		goto err_freehost;
> +	}
> +
> +	if (!pdata->select_slot && pdata->num_slots > 1) {
> +		dev_err(&pdev->dev,
> +			"Platform data must supply select_slot function\n");
> +		ret = -ENODEV;
> +		goto err_freehost;
> +	}
> +
>
