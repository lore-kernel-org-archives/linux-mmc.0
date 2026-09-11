Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080C42E8F8;
	Fri, 11 Sep 2026 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789110293; cv=none; b=B9o7ZoQP+IBFUavL0oZUzyDwSHhFecTv/p74r1KVYIs+gg06A7lbyr57thkfK8aLCqKi5mFL964PBE+sbq6WtZ+RQkfccZsbO12iiqgSQkp0M2tq4vCC1Gg1t7BnP11D2pDVPxEdvJ5VBNrBvNVK8xI37iwzTFIAntQ9RCr51wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789110293; c=relaxed/simple;
	bh=5wjjclgMQHcLBZziHA24E6wMzIJIbKl/2zFWVYpkc/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjMgdclmdrNlrxuGEK/J89jA8lzK4Z3cHJ+nDEx3sLHv6/6SXKiKx7NPCd9Uzivrw0ZUjmsWa0dxhLIKP0IF4X381pQPtZJBqxS28nYyy1/yDAnpbGhREo96RV7ePp9oCiCRNY5c0J+A8BZ0PL60xOfX8cT+ARxiRLnvyjZFaGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvJnAOn2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvJnAOn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA011F000FF;
	Fri, 11 Sep 2026 07:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789110282;
	bh=5wjjclgMQHcLBZziHA24E6wMzIJIbKl/2zFWVYpkc/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EvJnAOn2t5c2JyRwCjOcrewLe6nb9xlMWqS/EbwJbHziNIcmH3pvJRGNqvuJyUP//
	 +iHGwlbINk8DvJOJP64VTvFZxYgQQEsDajKkZkcGneN4Zs/nVq750P9jk3UtLwdJgq
	 xrafAah+Ur3KHzoFsl1cTsogFQuPBSE/N2TnSdrZkqMpWpeMgKoYm09wbW8waKBfCO
	 YqX8r7EUIT4Noq7OeFs3IKhPbC/3ab457Yk0megOUohvcT1ZVXrv3sUpjyuq5t6ujZ
	 RlcF3uFg4z5+nH8VX8niwT2XPd5m5us56ib8MLQfMTkb6a5iu2adO2H1l/WkqNmT/Y
	 32Jo5LY4yls8g==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x4vJP-00000002paD-15Jx;
	Fri, 11 Sep 2026 09:04:39 +0200
Date: Fri, 11 Sep 2026 09:04:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulfh@kernel.org>, Jakov Novak <jakovnovak30@gmail.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Shuah Khan <skhan@linuxfoundation.org>,
	syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com
Subject: Re: [PATCH] mmc: vub300: fix sleeping function call from invalid
 context in vub300_inactivity_timer_expired
Message-ID: <aqOoBwBav8JZhMQ9@hovoldconsulting.com>
References: <20260816153809.7067-1-jakovnovak30@gmail.com>
 <aoLCr8JEYaYxcJcQ@hovoldconsulting.com>
 <CAMuHMdU_Rx4ZGi9SsNxKUDyYmV-GbD8rD9NMVzYginBMXdZDMg@mail.gmail.com>
 <ap7CaVj82BJZgjf6@hovoldconsulting.com>
 <CAMuHMdX6JfqpLMGDQJSQ8E8XNobRwr16LOzuphPt3Afs-OZdJA@mail.gmail.com>
 <aqEDb0THnCM-Q_Vy@hovoldconsulting.com>
 <aqGWWhvL5CKH2mgx@shikoro>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ypLbD7kLLG8T2WMv"
Content-Disposition: inline
In-Reply-To: <aqGWWhvL5CKH2mgx@shikoro>


--ypLbD7kLLG8T2WMv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2026 at 07:24:46PM +0200, Wolfram Sang wrote:
>=20
> > > > Sure, but should you be scheduling rescan work before all resources=
 have
> > > > been set up and the host has been registered?
> > >=20
> > > I would like to defer that question to the TMIO experts.
>=20
> From a high level view, independently of TMIO/SDHI...
>=20
> > Are they on CC?
> >=20
> > Ulf, perhaps you can take a look at this? It seems wrong to enable
> > interrupts and trigger rescans before the host controller has been set
> > up and registered.
>=20
> ... it is always a good practice to enable irqs only when the device is
> fully set up. From a glimpse, this seems to be the case here as well.
>=20
> It needs serious testing, though. SDHI is a complex, organically grown
> mass of code. There might be subtle side effects. It should still be
> worth it IMO. I can put it on my todo list, but no promises...

Thanks for taking a look. I guess we should fix this inconsistency in
MMC core eventually, but that the vub300 needs to be reworked to handle
this quirk in the mean time.

If only to stop the flood of LLM generated fixes to the syzbot report...

Johan

--ypLbD7kLLG8T2WMv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCaqOoAxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQC8XNwux9ZQjVSwEAxhUSOYohLwgwRjbyWmph
LRJqFOQ5mdeMUjtJjqfls5QBAJg938/Rjigc5olijd6lXoUhvwQAtrP6iVEZ2z8t
EIwF
=3HVw
-----END PGP SIGNATURE-----

--ypLbD7kLLG8T2WMv--
