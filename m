Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B82222A9;
	Tue, 26 May 2026 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802704; cv=none; b=jFkaK0B4Q8suu4ygSNt4riIXtCFsGDf476/dsSV+M08mTGUwuxTLr668JbCUItp2fjwynufU8Oe4skE3n3HbjTBMB4b1dGr/CMZVHR4hcnpTsDUNKrAeJ+CpBa4WNLQ4lZfkWd8OgzGu9LevTB1yQg/6EVavJ70m5mdiyI1aXPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802704; c=relaxed/simple;
	bh=GKR6jAHMNd0M/COoz/zU2+k0T3766nM8cziPl83inEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qS2ZWJb0buG6cgxM9SLNL1Zf3Q/WJCf2X6e6+fn1NwXJR6aSJCyj397lLjJjFgy25MYWUfBxYVwY5RYsBwYP+4IUM+yFy1l7H30eaOT3x4vTa84VF98Mi2WKVcO47SJ5XZ5PoW1Ckmlj0DtC7CCQCqI5/axE6MbvNoS+7q6NtW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiu9R8Rn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiu9R8Rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164F71F00A3A;
	Tue, 26 May 2026 13:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802703;
	bh=oOKcXaMosfo/owsXW+WMOSw10vIYBJ3tP8qIY78PgJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oiu9R8RnVsntp+r4GoHbV3UbMUxnK42UzM7CQADH87umbw39O0GA9VnsLKsP66Dn1
	 FsGGTeVGEjCIfPU46hirCe5shVz/ClDseF7VTqF22ml+vLSz4iay+Gv0BGK2joRee2
	 Hm3S/PDdht6KVdBZCJ39zFgBbtVHVMmctVaoYRnc26S8bKIPpeh/IyT9L+78patlBg
	 +PKbBcB+pOMEw48XmdhVY5R5ZP9kO70UKk+lH0yDWVKpr4L1N7hgtFIUPeX/MJjhPu
	 KXORLa9eT94GCfBt6kUfzQfF/NBx7dZaARwhSfQE6DqbG5z3zWt05t9hoy8SoI9a9H
	 /tESKaH/O46Eg==
Date: Tue, 26 May 2026 13:38:21 +0000
From: Yixun Lan <dlan@kernel.org>
To: Andre Heider <a.heider@gmail.com>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Ulf Hansson <ulfh@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>,
	Vincent Legoll <legoll@online.fr>,
	Margherita Milani <margherita.milani@amarulasolutions.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: (subset) [PATCH v10 0/4] riscv: spacemit: enable SD card support
 with UHS modes for OrangePi RV2
Message-ID: <20260526133821-GKC3748271@kernel.org>
References: <20260515-orangepi-sd-card-uhs-v10-0-094af27e310d@gmail.com>
 <177889984452.2298656.1074391459031404894.b4-ty@b4>
 <7e68e745-0d70-46db-9475-38d3dd5b9cf4@baylibre.com>
 <6b945153-5a7b-415e-904a-1c350b7d52ee@gmail.com>
 <86ac46cd-b7bc-42cc-8c29-996ae21f3654@baylibre.com>
 <CABdCQ=M_E1uHU5WTXCn2mXaxf3-+7M9gXCL=tp1qBW50jf7d5Q@mail.gmail.com>
 <8b9c613c-df1a-4f44-b15d-cdcc21905bc5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b9c613c-df1a-4f44-b15d-cdcc21905bc5@gmail.com>

HI All,

On 18:45 Mon 25 May     , Andre Heider wrote:
> Hi Iker,
> 
> On 25.05.26 11:36 AM, Iker Pedrosa wrote:
..
> > 
> > So, how has this turned out in the end? Andre, will you take care of
> > sending the latest version for the MUSE Pi Pro?
> 
> Yes, in fact I already sent it last week:
> https://lore.kernel.org/spacemit/20260520130624.1763487-1-a.heider@gmail.com/T/#u
> 
Ok, I will take it
> You should have received that (unless I messed something up) ;)
> 
P.S, please bear with me, I'm currently on travel now, so may slow on this
-- 
Yixun Lan (dlan)
