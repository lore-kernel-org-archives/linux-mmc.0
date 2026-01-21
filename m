Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE2041B35A;
	Wed, 21 Jan 2026 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769030367; cv=none; b=ZnoCZNCTSCZOPnyXc2SxMqk3ngTYDWQrnG2CQrUVRHWmVICCGeLWbgk+1u0qBL/DgJB8UnQ8uggHCTFYqUtuwNR2+FTkOpuVP+2OoJuhe+Nht1l8isQ6wKyONLBgjqVXfvANn8IJjaC7ev0GpBb1OKPFxArqm2JBGq3IlgdkCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769030367; c=relaxed/simple;
	bh=FVLT0moz0hXIT61vPv39fMqdt1ghxk9g/CKJOwDLB4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ioqvct4D3rGrtuFu9lilEGIQTjTfS6re9qdXIuGQ5bACXkAfDpinZPhJan3xbD+vmtJchO19Ldf2MyRNnok92jqYDRITUlOlHAJ4DMj18NkljkdKobvCCDZYa/UpPb/myukGrV+SJZi1sx+r7hq65iFv5AdcPM1B+EOqvPRKbqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vifbR-000000004oU-2QVv;
	Wed, 21 Jan 2026 21:19:01 +0000
Date: Wed, 21 Jan 2026 21:18:58 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Chad Monroe <chad.monroe@adtran.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
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
Message-ID: <aXFCws0XUToQ03UH@makrotopia.org>
References: <20260121-dt-mtd-partitions-v3-0-ec3af93c8f93@kernel.org>
 <20260121-dt-mtd-partitions-v3-6-ec3af93c8f93@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-dt-mtd-partitions-v3-6-ec3af93c8f93@kernel.org>

On Wed, Jan 21, 2026 at 01:56:39PM -0600, Rob Herring (Arm) wrote:
> The partitions.yaml schema is an unusual structure in that it includes
> all possible partition types, and it disables the normal matching by
> compatible strings. As partitions.yaml has nothing to match on, it is
> only applied when explicitly referenced. The use of "oneOf" also results
> in misleading warnings which are difficult to understand. Drop
> partitions.yaml and rely on the standard compatible matching instead.
> 
> The "mmc-card" case previously allowed any partition type, but now only
> allows "fixed-partitions". There aren't any users and the original
> intent appeared to be only for "fixed-partitions".

It would actually be great to also allow 'gpt-partitions' as compatible
type with #address-cells = <0> and #size-cells = <0> and allow matching
on partition UUID, name or index. This has previously been discussed and
would avoid having to extract MAC addresses and WiFi EEPROM data in
userspace on many devices which rely on such conventions.

In OpenWrt I've implemented this as a downstream patch[1]...

[1]: https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/generic/pending-6.12/453-partitions-efi-allow-assigning-partition-Device-Tree.patch;h=cc2c20338aff476d3a5b028e71b08ea15a060daa;hb=HEAD
