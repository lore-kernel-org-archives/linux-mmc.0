Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801183B47EF;
	Wed,  9 Sep 2026 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937075; cv=none; b=O+klfkTqbY8g1F/wPNjnAkTZBXsfvNq8l/ZPHPhRRMjHhOeFfvekslcfz/FrWskH7ekEb39Nx+0E4L0nkj1werTuu+hu2OvKBle0ao8uLpJN6oIKqy81LbHzA+deFS6cIzpstAPq1Za3/MGbENORomX+NFiTDn2npJjw4DnnfII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937075; c=relaxed/simple;
	bh=R6nSpN66nYNxiPrTGKT4KB9m8gv/aA/+OCbdR3a2Tz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEwHwJ+Xr1tk1w8vwAuqT8bLyjLUYyVIzdFa2YLcUOKz0fTG+VCK8H66Yk03K+xPQoUN2x2zpwRLTyrdQPQrGpTWj5n3nomg5w/NliEv0TSjl3+n8YAcxfp/BtCScyPjvTZX+cOg8IdwV/rLN/FoES/vZyhMevL1Jsn8E7M9FT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVYO+/54; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVYO+/54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9BF1F00A3A;
	Wed,  9 Sep 2026 06:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788937074;
	bh=GvNb/3ZWr42JFzJtgrkEZJhaOUFBBzpaSg+e/nXYrAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KVYO+/54laGE834Lj+oF1Y3rSsrgdIjBQyml+scDo7fKvu+8+pHmvo2ixUAtEt7NZ
	 sLIwLs0g9Q9vkt/4sDFi8RYTlnAiDKki9UK0TrjCcY7rxEkDkHQBBoAKB38ITBOsFm
	 KTNCiG12vWqj7V4CHuoyIkJ11FOlE5D3mZCLwVAw8sc+j94YP+PV/YVLBnymSX9OdZ
	 VI1GIVS5SsH1DJbQ9kmcCC3+NHxeZLKzxL/Z/sy/JdaQfPs8WX8k8q5fXtTxlG01Vz
	 BrNuUodBaaxUcXTxCyiXth2AdD1BY7wtnzR8XCtONZJBwvuE9plObPqgeICvPUtOLx
	 ZUlB+ryK2g6eA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x4CFj-00000001ovP-3g9b;
	Wed, 09 Sep 2026 08:57:51 +0200
Date: Wed, 9 Sep 2026 08:57:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Jakov Novak <jakovnovak30@gmail.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Shuah Khan <skhan@linuxfoundation.org>,
	syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] mmc: vub300: fix sleeping function call from invalid
 context in vub300_inactivity_timer_expired
Message-ID: <aqEDb0THnCM-Q_Vy@hovoldconsulting.com>
References: <20260816153809.7067-1-jakovnovak30@gmail.com>
 <aoLCr8JEYaYxcJcQ@hovoldconsulting.com>
 <CAMuHMdU_Rx4ZGi9SsNxKUDyYmV-GbD8rD9NMVzYginBMXdZDMg@mail.gmail.com>
 <ap7CaVj82BJZgjf6@hovoldconsulting.com>
 <CAMuHMdX6JfqpLMGDQJSQ8E8XNobRwr16LOzuphPt3Afs-OZdJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX6JfqpLMGDQJSQ8E8XNobRwr16LOzuphPt3Afs-OZdJA@mail.gmail.com>

On Mon, Sep 07, 2026 at 04:48:00PM +0200, Geert Uytterhoeven wrote:
> Hi Johan,
> 
> On Mon, 7 Sept 2026 at 15:55, Johan Hovold <johan@kernel.org> wrote:
> > On Mon, Sep 07, 2026 at 02:17:45PM +0200, Geert Uytterhoeven wrote:
> > > On Mon, 17 Aug 2026 at 10:13, Johan Hovold <johan@kernel.org> wrote:
> > > > On Sun, Aug 16, 2026 at 05:38:09PM +0200, Jakov Novak wrote:
> > > > >  Currently, the function vub300_inactivity_timer_expired, which gets
> > > > >  called in a softirq context, calls a sleeping function in the following
> > > > >  call chain:
> > > > >
> > > > >  vub300_inactivity_timer_expired -> kref_put -> vub300_delete ->
> > > > >  mmc_free_host -> cancel_delayed_work_sync -> __cancel_work_sync ->
> > > > >  might_sleep -> BUG
> > > > >
> > > > >  Fix this by replacing kref_put(&vub300->kref, vub300_delete) with
> > > > >  vub300_queue_dead_work(vub300), which does the same thing, but in a
> > > > >  workqueue context.
> > > > >
> > > > > Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> > > >
> > > > This isn't the commit that introduced the issue. The blocking call in
> > > > mmc_free_host() was added by commit 1036f69e2513 ("mmc: core: Cancel
> > > > delayed work before releasing host") in 2023.
> > > >
> > > > I didn't look at this in any detail, but having that call in
> > > > mmc_free_host() (e.g. rather than in mmc_remove_host()) looks wrong so
> > > > perhaps the fix really lies in MMC core.
> > >
> > > mmc_remove_host() can only be called after a sucessful probe, while
> > > commit 1036f69e2513 fixed an issue where the last probe step failed
> > > with -EPROBE_DEFER.
> >
> > Sure, but should you be scheduling rescan work before all resources have
> > been set up and the host has been registered?
> 
> I would like to defer that question to the TMIO experts.

Are they on CC?

Ulf, perhaps you can take a look at this? It seems wrong to enable
interrupts and trigger rescans before the host controller has been set
up and registered.

Johan
