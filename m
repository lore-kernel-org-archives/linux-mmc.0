Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94411471277;
	Wed,  9 Sep 2026 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940944; cv=none; b=kinW65nYrV0kr2W3Ngg4oJLL0Xzlj3ldG9whLa+kehWXkbXKgUgPtZlulxTehN+gK/sCxO1YoCpW/t9cMchXH7lWV2RVMkN6VnG8kBPKF4HyQyTwkMrkUmXG5hWvOyl/pD54ZGeSGurKlibWAGriBdokOm2eSNoWKkNhh/S5vIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940944; c=relaxed/simple;
	bh=u2lvRYHXsCWp/lTMMlUC1kU83R9bpR1B3PSOasOvNnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWhf73I43hS4lDzdL767dLJpELkCrw72bT0BPK9C9279W/i1q6tuhJFtk618iELii+AvFryfs9lNX5cjCd93VMC1CFcqvgG+Tk7EgQr/ostnS5O+0cqpMqVLleUD2RIG0SbxB67RkJJaYhTlTOH05SYoNQjcCbL+xH7gplIMaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFSBvtL+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFSBvtL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31ECF1F00A3A;
	Wed,  9 Sep 2026 08:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788940943;
	bh=FifjGmW6Sh7JjhtvCMK2o/UaNn2Q1/ZuvVfOlpEY4O4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lFSBvtL+UjNsOM5WO8mvehrzUCakIZ0Rhq0vKyliMAyQ25MB30IKHea6kwq5Q0QEh
	 EKlVe47sJRZOjTXfoGugg0S+kh+xP5b1mJKqfZQsi6OJ/hhn7piWWyRWgBXSJUGFb/
	 VsQA8WF2SefI2aNkuw0XJTfhil/Vb7UjfPZDpgAaG62pT1zuWS1bvTCulgOJPJga6F
	 YLozBKg08p+T30heB7NTt/g/VBile7RTxsdo5nM9W366G2+3x1dHpdhTrCdeOrg2Fz
	 A0nyAnZyqxloC9ATwtMJzE8//36jCiL8KRBi/Oms1KaBRtkM9pcIxvqQsnLA6IDDYw
	 HevyJhktMfJaQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x4DG8-00000001zEV-2JGM;
	Wed, 09 Sep 2026 10:02:20 +0200
Date: Wed, 9 Sep 2026 10:02:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Jakov Novak <jakovnovak30@gmail.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Shuah Khan <skhan@linuxfoundation.org>,
	syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] mmc: vub300: fix sleeping function call from invalid
 context in vub300_inactivity_timer_expired
Message-ID: <aqESjExZsFW5dEtr@hovoldconsulting.com>
References: <20260816153809.7067-1-jakovnovak30@gmail.com>
 <aoLCr8JEYaYxcJcQ@hovoldconsulting.com>
 <CAMuHMdU_Rx4ZGi9SsNxKUDyYmV-GbD8rD9NMVzYginBMXdZDMg@mail.gmail.com>
 <ap7CaVj82BJZgjf6@hovoldconsulting.com>
 <CAMuHMdX6JfqpLMGDQJSQ8E8XNobRwr16LOzuphPt3Afs-OZdJA@mail.gmail.com>
 <aqEDb0THnCM-Q_Vy@hovoldconsulting.com>
 <CAMuHMdWK8j200+Of062ghV1E7b0BYWsufEAop_4+3Bhmi0sxVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWK8j200+Of062ghV1E7b0BYWsufEAop_4+3Bhmi0sxVQ@mail.gmail.com>

On Wed, Sep 09, 2026 at 09:38:24AM +0200, Geert Uytterhoeven wrote:
> On Wed, 9 Sept 2026 at 08:57, Johan Hovold <johan@kernel.org> wrote:
> > On Mon, Sep 07, 2026 at 04:48:00PM +0200, Geert Uytterhoeven wrote:
> > > On Mon, 7 Sept 2026 at 15:55, Johan Hovold <johan@kernel.org> wrote:
> > > > Sure, but should you be scheduling rescan work before all resources have
> > > > been set up and the host has been registered?
> > >
> > > I would like to defer that question to the TMIO experts.
> >
> > Are they on CC?
> 
> Ulf was from the beginning; I had added Wolfram in my previous email.

Thanks for clarifying.

Johan
