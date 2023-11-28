Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49213AD2
	for <linux-mmc@vger.kernel.org>; Tue, 28 Nov 2023 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0CknmWSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06171C433C8;
	Tue, 28 Nov 2023 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701157225;
	bh=sQ8eFRy8ecWkoljPx54B1yii7txseyEFBs2HyY8n+wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0CknmWSAvMLQx5OiL5X7KW4Iw2Mrbo6oKxUPdjCYpr07sE0c/WFbDsrkiNm1pS4g7
	 XdHyAQUn9+EDO59QVR6mA2OIJabxl1GhzzO0w44IMVaEAjwOyn4iMloe/g/P80fLVW
	 l1/Kojo5fk1mip0XLmakL/SIJxPquRGz46TiouYo=
Date: Tue, 28 Nov 2023 07:40:21 +0000
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Ricky WU <ricky_wu@realtek.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"yangyingliang@huawei.com" <yangyingliang@huawei.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] Support new card reader rts5264
Message-ID: <2023112848-handoff-wistful-dec5@gregkh>
References: <d166d6a70c46419f8d2670e63f542ea1@realtek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d166d6a70c46419f8d2670e63f542ea1@realtek.com>

On Tue, Nov 28, 2023 at 05:32:47AM +0000, Ricky WU wrote:
> Summary
> =======
> This series adds support new card reader rts5264
> rts5264 can support sd express card 
> new definitions and functions define in new file rts5264.h rts5264.c
> 
> Patch structure
> ===============
> v4->v5:
> add summary for this series

That is not what I asked for here.  Please make the changelog text for
the individual patches MUCH better.  Perhaps work with one of your
coworkers to come up with some more text that properly describes what
the change is doing?  Did you read the documentation link that I pointed
you at that should answer how to do this better?

Also, your patches are NOT properly linked together (look at them on
lore.kernel.org for proof), please use something like git send-email to
have them be linked so that we can apply them properly at the same time
together once they are ready.

thanks,

greg k-h
