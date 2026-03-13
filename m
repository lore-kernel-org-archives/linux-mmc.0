Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17E0374751;
	Fri, 13 Mar 2026 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773400271; cv=none; b=jfXI2Ffo3w1skRaii+OZJtBWEER7O42ptfgvaedBVLpAcR7cPNtjcOrDnxgEY/DrVBT8RF73EY3YHzZQnpZEjkXTJmOR05XT32wJ7NSRTu00AYj9J+T3lxkKoM6MJJB2Yq7p4HtJeraGoZI2jMZDdNFxDcSHcOoJ+PvYI8kwojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773400271; c=relaxed/simple;
	bh=r5oAxsSgqMEW7Ns8Az8YVhuyu0CrjtI8S+hb3nn7Tww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=go7von8ng4W0sP48lFBLn1Ex1CRbHLFgUmy51qpWefwIF7XBEJJ1dBVO3grbDkdVEDPTgLoNXrx7XsvXx8ibBPgOvgbYosCRQNfqO7sHofyIva1428CzDDVukhXVUg39c4PeYoT706kSywfOFysQTZ+K5Gau8CDTvEV6JKrNFYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgVyAec3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgVyAec3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55A5C19421;
	Fri, 13 Mar 2026 11:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773400271;
	bh=r5oAxsSgqMEW7Ns8Az8YVhuyu0CrjtI8S+hb3nn7Tww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgVyAec3WBE6a+ul+CXwo0AaKRP5WzH8ZLS9BMVWWGFh7Aqnqm65cC7Aj6cZiDf9N
	 8uYUbKxlSm+MuEsEeVuIuFv9z9y1NQBlflrhJy3ZqMshL1Hv019lPjy5YEdvQiCPdn
	 mfwgmVqCGSWFSEW0Qrlz9VgIZBUWqxG9htt306LntceicurnjHdAwoLJDNWBKGp2n0
	 ObwkT6QgDYc6WfaSDIbhNyZWP5A7QEABvKF5VADPiWGUxjfV5rOKGR/Jt2ADIdP2Wk
	 Y5wwFk0YVAEiSBkYxX5++OwYocWVRS8W19PoWV4U59FsPp4RrEBBshzLF2ySHCFsic
	 eikAZFINoXWYA==
Date: Fri, 13 Mar 2026 19:11:08 +0800
From: Yixun Lan <dlan@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] riscv: dts: spacemit: k1-orangepi-rv2: add PMIC
 and power infrastructure
Message-ID: <20260313111108-GKM302167@kernel.org>
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
 <20260309-orangepi-sd-card-uhs-v2-6-5bb2b574df5d@gmail.com>
 <8e91c86d-ea41-4535-a7cd-5b602c546cb7@baylibre.com>
 <20260313001940-GKA407679@kernel.org>
 <CABdCQ=Mv-3X8KE1WOWKVTmq+POgJczsL-qFdAyp5qzM6=0s28A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdCQ=Mv-3X8KE1WOWKVTmq+POgJczsL-qFdAyp5qzM6=0s28A@mail.gmail.com>

Hi Iker,

On 10:42 Fri 13 Mar     , Iker Pedrosa wrote:
> El vie, 13 mar 2026 a las 1:19, Yixun Lan (<dlan@kernel.org>) escribió:
> >
> > Hi Trevor, Iker,
> >
> > On 14:27 Wed 11 Mar     , Trevor Gamblin wrote:
> > > Hi,
> > >
> > > On 2026-03-09 07:40, Iker Pedrosa wrote:
> > > > Add Spacemit P1 PMIC configuration and board power infrastructure for
> > > > voltage regulation support.
> > > >
> > > > - Add board power regulators (12V input, 4V rail)
> > > > - Enable I2C8 for PMIC communication
> > > > - Configure PMIC with buck4 (vmmc) and aldo1 (vqmmc) regulators
> > > > - Set up regulator constraints for SD card operation
> > > >
> > > > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> > > > ---
> > > >   arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 48 ++++++++++++++++++++++++
> > > >   1 file changed, 48 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> > > > index 7b7331cb3c726f11d597f81917f3a3f5fc21e1b9..414b03f5e6480f05f5d7eeaaa0afb4e86425ae36 100644
> > > > --- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> > > > +++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> > > > @@ -19,6 +19,25 @@ aliases {
> > > >             ethernet1 = &eth1;
> > > >     };
> > > >
> > > > +   reg_dc_in: dc-in-12v {
> > > > +           compatible = "regulator-fixed";
> > > > +           regulator-name = "dc_in_12v";
> > > > +           regulator-min-microvolt = <12000000>;
> > > > +           regulator-max-microvolt = <12000000>;
> > > > +           regulator-boot-on;
> > > > +           regulator-always-on;
> > > > +   };
> > > > +
> > > Is this the correct voltage? I don't see a 12V rail in the RV2's
> > > datasheet, and the board's specifications only indicate a 5V USB-C input.
> >
> > Right, this should be fixed. Please note Han submitted one version of basic DT for rv2
> > which I think that series will go in first
> >
> > https://lore.kernel.org/r/20260310161853.3900605-1-gaohan@iscas.ac.cn
> >
> 
> I'm fine with that. Do we have an estimate of when these changes will
> land? I'm fine with rebasing once those are merged, but I'd like to
> continue with the review for the remaining changes in this patch
> series and I'm unsure on how to proceed.
> 
For that changes, likely will target v7.1 merge window

You can continue with current version, once that happen, you can rebase ..

-- 
Yixun Lan (dlan)
