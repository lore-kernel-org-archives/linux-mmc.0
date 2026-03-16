Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C13254AE;
	Mon, 16 Mar 2026 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677031; cv=none; b=nOKf7LBa5P/zV9+HK5eVVPtR0WANJTQf8dFg7B6Z9pS0gv+cMe18K9SWKkpeoiqGP2vc9sYH87zjsKqpTc9eTTDpw0O36mOwCbV4xfQVTdZJ82XAgtpE+kcr5bEBvIcYuh3vs01/vvyZAfBuk3r9w2tJHiqmyVw1cHK5UBYkFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677031; c=relaxed/simple;
	bh=k2epx7YD0jM8IXyjSFIrBoicPdg0GlitTL85w2hyFCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipsAW2dFaANrnN3XQbh8zLF9bx1njP8kTFv35MvEG2x9zqAUOmZEMjIDBbbLcJavVMUKmJlnnBVrj8SPDwzTr9CwZunhdWaSV6wFgJH+SUZzv0eWZkpzGYFQwObznvyYRadd6mqYZES3tXIkFXOuuzfkPANOEndzeJxuHKcpYS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from duge-virtual-machine (unknown [183.192.222.244])
	by APP-01 (Coremail) with SMTP id qwCowACXA2_RKbhp5nRBCg--.1107S2;
	Tue, 17 Mar 2026 00:03:30 +0800 (CST)
Date: Tue, 17 Mar 2026 00:03:28 +0800
From: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	gaohan@iscas.ac.cn, me@ziyao.cc,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH v4 3/3] riscv: dts: canaan: Add mmc nodes for K230
Message-ID: <abgp0PT4GHRwmaLy@duge-virtual-machine>
References: <20260315054426.18383-1-jiayu.riscv@isrc.iscas.ac.cn>
 <20260315054426.18383-4-jiayu.riscv@isrc.iscas.ac.cn>
 <DH49Q7OQSIYM.1RD7H0L809JQV@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DH49Q7OQSIYM.1RD7H0L809JQV@pigmoral.tech>
X-CM-TRANSID:qwCowACXA2_RKbhp5nRBCg--.1107S2
X-Coremail-Antispam: 1UD129KBjvJXoWruw1kCr1fAFW5ZF4fGF4kZwb_yoW8JrW5p3
	y7CFW5GF4kXr17KF1Sq34jgrnxAayfJrn7Wr17tFyUJryavr90kr1Fqw4qgry7Xr40kr42
	kw4UXryxWr4YkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxU7WrWUUUUU
X-CM-SenderInfo: 5mld534oul2uny6l223fol2u1dvotugofq/

On Mon, Mar 16, 2026 at 10:15:27PM +0800, Junhui Liu wrote:
> Hi Jiayu,
> Thanks for the new version. Just a friendly reminder.
> 
> On Sun Mar 15, 2026 at 1:44 PM CST, Jiayu Du wrote:
> > Add MMC nodes to K230, including eMMC and SDIO. Enable HS200 eMMC
> > on the SoM and SDIO high-speed on the board.
> >
> > Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
> > ---
> >  .../boot/dts/canaan/k230-canmv-dshanpi.dts    | 56 +++++++++++++++++++
> >  .../dts/canaan/k230-canmv-module-dshanpi.dtsi |  7 +++
> >  arch/riscv/boot/dts/canaan/k230.dtsi          | 28 ++++++++++
> >  3 files changed, 91 insertions(+)
> 
> [...]
> 
> > +
> > +&sdio {
> > +	bus-width = <4>;
> > +	max-frequency = <50000000>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc1_pins>;
> > +	vmmc-supply = <&vdd_3v3>;
> > +	vqmmc-supply = <&vdd_3v3>;
> > +	cap-sd-highspeed;
> > +	no-1-8-v;
> > +	status = "okay";
> >  };
> >  
> 
> It seems the broken-cd property we discussed in the previous version is
> not added, and also my Tested-by tag (for the whole series). Was this
> intentional or just an oversight?
> 

Sorry for that, It was a oversight. I will fix both.

And I will only add your Tested-by tags to patch [2/3] and [3/3].
Is this correct?

Kind regards,
Jiayu Du

> -- 
> Best regards,
> Junhui Liu
> 

