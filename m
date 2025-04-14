Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594A219F130;
	Mon, 14 Apr 2025 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642644; cv=none; b=bxGd3MQinOmstudzUgNx7kgUCsDlCcACI8j8QasuUyjIJYAPRdk4hNQkzWfyNP0iynyJn6nicVx/urbVd8vwrd4lFbiFowanTVKIf/4yqryP3QM/Y+tugHuvCw6U8eCw+hGtMiEyaPXDflRcjeWHybdGsa/Mjvsh5H89FgVxVYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642644; c=relaxed/simple;
	bh=SGurqnDTwGQqt7VnQak1Gr21rDfjF4zfWiv+Vz/bzyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qudw9zBx9yZ2Q0New1c7ysGgF8a6IhFIKtYX6rpdEJZTA5tlucfA2vtTcgsizbQTrUCURSj1yhshWYk4tDQuE7LOPtm+Ntxx6BTFO63+IxtzUvGRYSUEPPGy74Z4L+TScm6kYJJSCIOAAMJGxqiw+dUTyeFEWNR9WOKalr2DfD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=mHArkJhz; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="mHArkJhz"
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 70D741F93C;
	Mon, 14 Apr 2025 16:57:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744642637;
	bh=cyeKeCAcuH3S7JCIv0170g0jwezsswjGC82t2IsOcf8=; h=From:To:Subject;
	b=mHArkJhzqYoR9InBBrA6sxzzbD14A5j2eoUpotqY781DBhPnOT2tEZfbvosPXrfDr
	 4zNkS3w6ckC1+9an3WNsT0hqeKEUmJ09nIKsNTSlBElv1TZ9peUARv6ihGc4ZBAvlM
	 vmxN+XHYcXmYMbGW28p7pju3yiXdLEd/68GxIqXkbL3fBzksoVjmGtHGxkMMf4dEUJ
	 65axAjx3ZoafvZS4I7yvvtbotNcd+W1JkiwvMZ791ZzjXGv0hDkf5ZUfG1qA0C4BnN
	 CbrEECfhnRWSlN60Bt1xGyZWnfVu5HOdZzfSDzjG+q0LwhgKoUwdj6QZOp0uAhuXCs
	 VPLx+XkJvkv2Q==
Date: Mon, 14 Apr 2025 16:57:12 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Judith Mendez <jm@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Hiago De Franco <hiagofranco@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Josua Mayer <josua@solid-run.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Moteen Shah <m-shah@ti.com>,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH 0/2] Fix V1P8_SIGNAL_ENA and HIGH_SPEED_ENA
Message-ID: <20250414145712.GA59296@francesco-nb>
References: <20250407222702.2199047-1-jm@ti.com>
 <20250411130354.dc3sv3e7ruekkhkp@hiago-nb>
 <d8e45e50-f0eb-41d0-9c50-56147eaf262a@ti.com>
 <20250411194813.c4ft2uxgdiuza5cm@hiago-nb>
 <5f36ec5d-bb31-4b6c-aa4e-4ec48cb1d067@ti.com>
 <20250414065119.GA6309@francesco-nb>
 <65119d3a-6907-4911-ba19-e3bcdb65b529@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65119d3a-6907-4911-ba19-e3bcdb65b529@ti.com>

On Mon, Apr 14, 2025 at 09:37:53AM -0500, Judith Mendez wrote:
> Hi Francesco,
> 
> On 4/14/25 1:51 AM, Francesco Dolcini wrote:
> > Hello Judith
> > 
> > On Fri, Apr 11, 2025 at 04:55:39PM -0500, Judith Mendez wrote:
> > > My understanding was that we do not like adding new DT properties if
> > > we can find a way to apply the quirk in the driver.
> > ...
> > 
> > > If this implementation flies with the maintainers, then we can go back to DT
> > > property implementation.
> > 
> > Not sure if this is clear, but this patch is NOT working according to
> > our tests, we would need to fix it in a different way.
> 
> Not sure if you are following the thread with Hiago, but we are fixing
> it a different way; add a new DT property: "ti,suppress-v1p8-ena" for SD
> card which allows us to have granular control on when v1p8 is suppressed
> for MMC1.
> 
> With this method, we make sure the quirk is never applied to your board (;

My board needs the quirk ;-)
It was not clear to me that this change was going to be added to this
patch, because without it's not working.

Thanks for the clarification.

Francesco

