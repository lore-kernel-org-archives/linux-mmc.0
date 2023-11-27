Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02053033D
	for <linux-mmc@vger.kernel.org>; Mon, 27 Nov 2023 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MphXs9bt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D53DC41679;
	Mon, 27 Nov 2023 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701093268;
	bh=LgvZU5k7cgHeOMUcETAIPa4Pu0VIlDFzMv+d5VcByyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MphXs9btSX61mRsNhuH7amT+CEyvbZGPGONeRjDm1bDwnQxl9FbO/xMVPVw8ZXQG2
	 1+z2XV6Yf4mLvll0mvsHjNj1u6jHpBsRe1MqloE/lELxahquKtzbACVTwMQu6UvOdu
	 nYl0ff4tkT1bcGyIwRTf3+R9xxTuh41nZMXUve34=
Date: Mon, 27 Nov 2023 13:40:07 +0000
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Ricky WU <ricky_wu@realtek.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"yangyingliang@huawei.com" <yangyingliang@huawei.com>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] misc: rtsx: add to support new card reader
 rts5264 new  definition and function
Message-ID: <2023112714-tarmac-reapprove-7f75@gregkh>
References: <bf45a73f01cc43669dc3796ccff25598@realtek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf45a73f01cc43669dc3796ccff25598@realtek.com>

On Mon, Oct 30, 2023 at 03:55:30AM +0000, Ricky WU wrote:
> rts5264.h new definitions for new chip rts5264
> rts5264.c new functions for new chip rts5264

I'm sorry, but I do not understand this changelog at all.

As my bot would say:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

Please read that and fix up and resend this as a proper patch series
(your patches are not connected somehow).

thanks,

greg k-h
