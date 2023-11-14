Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D23A28E
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="skCpHjl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D992BC433C8;
	Tue, 14 Nov 2023 13:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699967825;
	bh=95s2UhAyv7w3qkWGxOMjyvVxTKgmywcvyhwdCB9sRus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skCpHjl77gyyq3x8ZmKDtmcQ0WaVAtMKkeKcpSd/Wkj3+5+034RBC/OUtMmcwbD5D
	 vanenJlaqbnsTeN9t9K3EvtQ4XviPFqNOgKEgn9CrxmLPaaRyX5bXu7cUhybXZWTu4
	 MO0yV4Cox/hkGrQQ5YBsFSRhVitsrCfdllerzNl0=
Date: Tue, 14 Nov 2023 08:17:03 -0500
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
Message-ID: <2023111423-unloved-preflight-fc7f@gregkh>
References: <bf45a73f01cc43669dc3796ccff25598@realtek.com>
 <5342711849f545f783d9b0f40f4dd94f@realtek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5342711849f545f783d9b0f40f4dd94f@realtek.com>

On Tue, Nov 14, 2023 at 02:27:36AM +0000, Ricky WU wrote:
> Hi Greg k-h and Ulf hansson,
> 
> Can I know what is the status of this patch?

The merge window _just_ ended yesterday, please give us a chance to
catch up with patches and reviews for everything that has been submitted
in the past 2 weeks.

To help that out, please review other changes that have been submitted
for the misc subsystem, which will help move your patches to the top of
the list.

> This new Reader is going on some new product, need this patch to support

The earliest this will end up in a release will be the 6.8 kernel, and
we do not have deadlines for new features, it will be merged when it has
been properly reviewed.

thanks,

greg k-h
