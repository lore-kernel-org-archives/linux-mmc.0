Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DCC3DC96F;
	Thu, 22 Jan 2026 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100173; cv=none; b=uN/rSQlcbKNdMao2Jqz3QDZRSRXbbgzuK0HRVMCMl7/CLxCtn97mlkZOcTbWnX734arxo2rg49pIk2ImQfcg2lXK67oAPQXwNNf0MP3FsVLkIDl84sr5IdkESRza3QeJTQavzxuCEp3nBbz6vFYBg2SPs73+eQlUUK4hfbn57qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100173; c=relaxed/simple;
	bh=6P0n0yRlYMIV56MqouKV3LIVah5f3lMN4f0w/T0gbNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpi2yqQs5nMyrIJ+VqlCtzovgrJc3b6lzlcDlhp/SqJZN0fYaDs8Lx7FOw6mS06V4LO7cIEJeOjmUbIwpD0DQjCcbpZ+nGxIx8bGFwoGMS+b9XnT9XHcTWy9l/95OcGxn8AF44xllqYfmywAWj+ZJ35WT4Ra8kbsX+/ImMGzWYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vixlK-000000001Tb-1Okc;
	Thu, 22 Jan 2026 16:42:26 +0000
Date: Thu, 22 Jan 2026 16:42:23 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Chad Monroe <chad.monroe@adtran.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Kamal Dasu <kdasu.kdev@gmail.com>,
	William Zhang <william.zhang@broadcom.com>,
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Simon Glass <sjg@chromium.org>, Linus Walleij <linusw@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 06/10] dt-bindings: mtd: partitions: Drop
 partitions.yaml
Message-ID: <aXJTb0-YMu9gf5SB@makrotopia.org>
References: <20260121-dt-mtd-partitions-v3-0-ec3af93c8f93@kernel.org>
 <20260121-dt-mtd-partitions-v3-6-ec3af93c8f93@kernel.org>
 <aXFCws0XUToQ03UH@makrotopia.org>
 <87tsweos4l.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tsweos4l.fsf@bootlin.com>

On Thu, Jan 22, 2026 at 11:31:54AM +0100, Miquel Raynal wrote:
> On 21/01/2026 at 21:18:58 GMT, Daniel Golle <daniel@makrotopia.org> wrote:
> 
> > On Wed, Jan 21, 2026 at 01:56:39PM -0600, Rob Herring (Arm) wrote:
> >> The partitions.yaml schema is an unusual structure in that it includes
> >> all possible partition types, and it disables the normal matching by
> >> compatible strings. As partitions.yaml has nothing to match on, it is
> >> only applied when explicitly referenced. The use of "oneOf" also results
> >> in misleading warnings which are difficult to understand. Drop
> >> partitions.yaml and rely on the standard compatible matching instead.
> >> 
> >> The "mmc-card" case previously allowed any partition type, but now only
> >> allows "fixed-partitions". There aren't any users and the original
> >> intent appeared to be only for "fixed-partitions".
> >
> > It would actually be great to also allow 'gpt-partitions' as compatible
> > type with #address-cells = <0> and #size-cells = <0> and allow matching
> > on partition UUID, name or index. This has previously been discussed and
> > would avoid having to extract MAC addresses and WiFi EEPROM data in
> > userspace on many devices which rely on such conventions.
> 
> Out of curiosity, why not exposing this data through an NVMEM cell
> instead? Anyway, this (re?)addition can probably be part of a follow-up
> series and is almost orthogonal to this cleanup IMO.

Exposing this data via NVMEM cell is exactly what I'd like to see.
However, for that the location of the data to be exposed as NVMEM cell
needs to be identified in the same way as done by the stock firmware,
which uses a GPT partition name in case of Adtran, for example.
