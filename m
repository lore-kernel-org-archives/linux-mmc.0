Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2564B45DF68;
	Mon, 14 Sep 2026 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388938; cv=none; b=BWI4uVEFOC6pLnV5X1e/G0/OqOy+fdzBgSL+udKSGgagai0iMOTKBekYr7vw/FI0EWjVrN0r8LLFJyddpeSdHbSJFwqw0HLB0E+zEEd47jCKLzsZ5lotiixPJfWEauZg+jWeuLBRwDUYlU7G3l6Mv8aiXl4e4yzhxq9yQgjs8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388938; c=relaxed/simple;
	bh=a/sGyoaxrAUbVh+o5UPxtnjNV3daqp2e3L87v3wFogQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmqCuK2rRX0TXso9vZiQ2Q73zDpcxcuvnR/oLydvgIBg8q3GXA6K+TDza8oYn6idU8QRRpLDqIPXYVUzIiGgRkPQBrgAEifiHsBHRIlZqCvJVZyCbL/8GlKkJguPMwgCQWfAlRWRXVYbvoKeN+/Dl07BiSC0KFmgB/NhQFfhnmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWWGRRHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWWGRRHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A378B1F000FF;
	Mon, 14 Sep 2026 12:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789388936;
	bh=+qlh1VbO0SyoEVKnvEfyQ9fT3hZrDXAh6A7IW4+sy80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hWWGRRHWpF0SRKxkqoPdJOMP3oih97enzfC12BwxEQZxhlZbWDR6zVhdDWs7T9G2Q
	 4yDmXBrzRaUwAeJ3Gwbw0EKBbdurogRdLqK4CN7x7O6z+OGY2taNT6ivurUbDlGxN1
	 tPZLZPv+n44pCI6kEcFeGr5ZBBcnPdrpYWCampX+61Mo3YU81ACLldDvSpzLhbdspV
	 8LcN0d2FdLr06tcHhYn3zUtN2W4tNgG6GXRyUVx3J0CI6c0f/X9XNVBGogI7snBB8C
	 DLK/8a620Fzld722XbFi3v1lYdYdcDr25ZiqNEOq7bO++N10CIdvQINCL0XHfI5N9J
	 eBgnnnFJTc4DQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x65nq-00000004IeV-1amM;
	Mon, 14 Sep 2026 14:28:54 +0200
Date: Mon, 14 Sep 2026 14:28:54 +0200
From: Johan Hovold <johan@kernel.org>
To: Jakov Novak <jakovnovak30@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Shuah Khan <skhan@linuxfoundation.org>,
	syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com
Subject: Re: [PATCH] mmc: vub300: fix sleeping function call from invalid
 context in vub300_inactivity_timer_expired
Message-ID: <aqfohk7axSSqbpuX@hovoldconsulting.com>
References: <20260816153809.7067-1-jakovnovak30@gmail.com>
 <aoLCr8JEYaYxcJcQ@hovoldconsulting.com>
 <CAMuHMdU_Rx4ZGi9SsNxKUDyYmV-GbD8rD9NMVzYginBMXdZDMg@mail.gmail.com>
 <ap7CaVj82BJZgjf6@hovoldconsulting.com>
 <CAMuHMdX6JfqpLMGDQJSQ8E8XNobRwr16LOzuphPt3Afs-OZdJA@mail.gmail.com>
 <aqEDb0THnCM-Q_Vy@hovoldconsulting.com>
 <aqGWWhvL5CKH2mgx@shikoro>
 <aqOoBwBav8JZhMQ9@hovoldconsulting.com>
 <DLCFZ1Z5FV92.3JAXNVQWJZGN8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLCFZ1Z5FV92.3JAXNVQWJZGN8@gmail.com>

On Fri, Sep 11, 2026 at 01:14:20PM +0200, Jakov Novak wrote:

> > Thanks for taking a look. I guess we should fix this inconsistency in
> > MMC core eventually, but that the vub300 needs to be reworked to handle
> > this quirk in the mean time.
> 
> Should I send a v2 based on my first patch with the Reported-by,
> Tested-by and Fixes tags fixed or is there something else I missed? 

It seems we don't need to worry about this driver anymore:

	https://lore.kernel.org/lkml/20260914111642.169707-1-ulf.hansson@oss.qualcomm.com/

Johan
