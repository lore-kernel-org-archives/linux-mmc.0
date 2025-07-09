Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EDB2DA75A
	for <linux-mmc@vger.kernel.org>; Wed,  9 Jul 2025 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065995; cv=none; b=IVCrq8GL+8cZalnx43/od4NwRu71SPTEvn82wuCJKng2wLbRhoSqGInwAyuR/LqIAqtPQRZBZidBgW4WPjE3PkaxUvNIF4uOFJ2LMbyXOmDGcOI0KEsfxt4dERijGSEGlUudIMtfPGrnzW5LYTOmuie+fVG0najKCI7GCX9f9e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065995; c=relaxed/simple;
	bh=73HvCjZMR3NAONLsS+S3QA3LeRAsQsSR67UYbxWMLaQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ISgBwe3cC5tfmkzDGmnCyzeTcDs38MH1ZQjqTBJEQNuWKgz6aNokic2UHqDNjekr+cZqGmvX5wHpH+KvMCordPGOOLErjt2K9jYWAI2pZM8R9h8kvVnY+zoWupnrRfRQg8BwXv1gPOA8AFg6UQzCwQ1B95VY9I8xPeq2SlStY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=d0DVuRhx; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=0aj/edMY; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="d0DVuRhx";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="0aj/edMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752065989; x=1752670789;
	d=konsulko.se; s=rsa1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=qvgF4Vfu8p4aaVuABgyc+Dl6SwSN6dTAercSz7+X1S4=;
	b=d0DVuRhxoRcIwWofcKJ7HElAXr5N6lXBnI4A0501KhSwYAVP6ftxztpmA4k+NH6+KoejY66xArC9C
	 8rsStUfp6rsb+UONX7jOer5SCQK5e9OlnLBZMVxlzEYidz6vwlHZqehJMk1m+5RZdYGnt+NO05LhAp
	 CKV18v6Eps3rtryhFOmVk9J7zbrV0vO4SFY0jwpNORvBH78jMQpB1Y9ZtGhcSvEZv9WM6nNp11IyhH
	 khkA1IQGpFyDANkqw1lzE3MEkYXbN4Jr+552eNA45weItTuBXwMKZ29XGS5BeYbyqGW65KjP2LS3pI
	 dl/vi2tU0sIW39/Cu6Oo/iG2eAQ1z4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752065989; x=1752670789;
	d=konsulko.se; s=ed1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=qvgF4Vfu8p4aaVuABgyc+Dl6SwSN6dTAercSz7+X1S4=;
	b=0aj/edMYvElvZ1eCqng8u1sxgfhXl6kn2ngXQFgreGmi5deYnPSV77kYaHVOpnjMRAlwYzm+aErNu
	 wbECpttDg==
X-HalOne-ID: 974e8fe1-5cc4-11f0-9748-f3c0f7fef5ee
Received: from smtpclient.apple (c188-150-224-8.bredband.tele2.se [188.150.224.8])
	by mailrelay4.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 974e8fe1-5cc4-11f0-9748-f3c0f7fef5ee;
	Wed, 09 Jul 2025 12:59:49 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] MAINTAINERS: add mm folks as reviewers to rust alloc
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <20250708183747.104286-1-lorenzo.stoakes@oracle.com>
Date: Wed, 9 Jul 2025 14:59:38 +0200
Cc: Danilo Krummrich <dakr@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 rust-for-linux@vger.kernel.org,
 linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B9E265F-A29D-42BB-BA61-E7258AF8E8A5@konsulko.se>
References: <20250708183747.104286-1-lorenzo.stoakes@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
X-Mailer: Apple Mail (2.3826.200.121)



> On Jul 8, 2025, at 8:37=E2=80=AFPM, Lorenzo Stoakes =
<lorenzo.stoakes@oracle.com> wrote:
>=20
> The alloc implementation is a thin wrapper over slab/vmalloc, so to =
help
> out on the mm side of things and to be cc'd on changes, add some mm =
people
> as reviewers.
>=20
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks for bringing more clarity to this, appreciated.

~Vitaly

> ---
> MAINTAINERS | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 71599ab6bd56..54dd937160ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21751,6 +21751,10 @@ K:	\b(?i:rust)\b
>=20
> RUST [ALLOC]
> M:	Danilo Krummrich <dakr@kernel.org>
> +R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> +R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +R:	Uladzislau Rezki <urezki@gmail.com>
> L:	rust-for-linux@vger.kernel.org
> S:	Maintained
> T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
> --=20
> 2.50.0
>=20
>=20

