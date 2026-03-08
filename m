Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FF133D4FF;
	Sun,  8 Mar 2026 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772993066; cv=none; b=evanzn5K7MbmmizxdnVeCXQqqOJhMLj34o7edhmRcue06CfJspc1icgB0KMekAY3f10dgpiIY5NnMlWJnnIxqZ7j8fKrWzX3QxV+Rl3FjcW/tb3p+isKefnf/4Ea4tM/3uuWOqRj3Qou52OKdJMn+jfb+UvJ3dWvvsv+ffxCp3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772993066; c=relaxed/simple;
	bh=Jsf8MO0q66btRAxmlmGT1CyFSsNARUXtwf7oPLFi3oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwnQw2R3A2hprrwDOLfyo+hSvigQVtkhy/I6HkzuALf+C9J9WdJWzt6NG05YQApp1koiTKd2KguJfH2QBeHmHd72X+4p3blKKRCWVl0JiPF66VqyP+cIgYqfU8/zPrf4h27etfeU1qOmuG4y8S29kuOIdsiK63uLuuR5FvMFJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYkf6vzk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYkf6vzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C498AC116C6;
	Sun,  8 Mar 2026 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772993066;
	bh=Jsf8MO0q66btRAxmlmGT1CyFSsNARUXtwf7oPLFi3oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYkf6vzkUsPbFgaI4x8bKxiVhuB43/z91/3Dy0XrEMNix1z8WyP2kNNymnmaT+9R6
	 dfK4hq0TNQVVAx+lv9K40rBYs4wSTVp8q+PDlnplS4hWWrbqpUPY6p1Qv0e1qFn8tK
	 Vqkp5CAjWZpFGcWsyreuq6sqbsw+V3XfZVa4ca70=
Date: Sun, 8 Mar 2026 19:04:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH] mmc: meson-gx: fix potential use-after-free on remove
 path.
Message-ID: <2026030856-legend-badly-9de0@gregkh>
References: <2026022313-cling-pastime-4551@gregkh>
 <CAPDyKFqDfh7Nwy5513wSAbebUSQLMaFGRV-aNSeW7Ev6bi-5kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqDfh7Nwy5513wSAbebUSQLMaFGRV-aNSeW7Ev6bi-5kg@mail.gmail.com>

On Wed, Mar 04, 2026 at 05:29:23PM +0100, Ulf Hansson wrote:
> On Mon, 23 Feb 2026 at 14:49, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Just like in commit bd2db32e7c3e ("moxart: fix potential use-after-free
> > on remove path"), we should wait until after we are finished writing to
> > the mmc host device before removing it, otherwise it could have been
> > already freed.
> >
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: stable <stable@kernel.org>
> > Assisted-by: gkh_clanker_2000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/mmc/host/meson-gx-mmc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> > index 694bb443d5f3..9557f6816af3 100644
> > --- a/drivers/mmc/host/meson-gx-mmc.c
> > +++ b/drivers/mmc/host/meson-gx-mmc.c
> > @@ -1297,13 +1297,13 @@ static void meson_mmc_remove(struct platform_device *pdev)
> >  {
> >         struct meson_host *host = dev_get_drvdata(&pdev->dev);
> >
> > -       mmc_remove_host(host->mmc);
> > -
> 
> No, this is actually correct.
> 
> My reply for the other patch to the moxart driver explains why.

Ok, then the commit above should probably be reverted or at the very
least, have the CVE rejected for it.

thanks,

greg k-h
