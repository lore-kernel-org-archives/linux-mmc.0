From: Vijaya Kumar K-1 <vijay.kilari@stericsson.com>
Subject: RE: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize
	latency
Date: Mon, 27 Jun 2011 18:34:52 +0200
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B1CAA1029EC@EXDCVYMBSTM005.EQ1STM.local>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
	<BANLkTikOA3G0Gt4Cxua3EDnAzbFKLAk6Yw@mail.gmail.com>
	<BANLkTimfxrcKWLZJmVC+1zL27th7j4uzEA@mail.gmail.com>
	<20110623133702.GZ23234@n2100.arm.linux.org.uk>
	<BANLkTi=8Awu4Z3ESizE9WDEyWNw0r9N0ug@mail.gmail.com>
	<BANLkTinK88QT_7Zr2YF1sTAiM778Xp9rFQ@mail.gmail.com>
	<20110627100212.GA16103@n2100.arm.linux.org.uk>
	<BANLkTi=NTqQ-U8AhL0SUYzBTs1RF==aD5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BANLkTi=NTqQ-U8AhL0SUYzBTs1RF==aD5g@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Robert Fekete <robert.fekete@linaro.org>, Per Forlin <per.forlin@linaro.org>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

  The below are the timings on clean & flush.

/*
Size	 Clean	 Dirty_clean	Flush 	Dirty_Flush
	 T1(ns)       T2(ns)	      T3(ns)      T2(ns)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
4096	 30517	  30517		30517	      30517
8192	 30517	  30517		30517	      30517
16384	 30518	  30518		30518	      30518
32768	 30518	  30518		30518	      61035<--
36864	 61036	  61036		61035	      61035
65536	 91553	  91553		91553	      91553
131072 183106	  183106		183106	183106

Full	 30518	  30518		30518	      30518<--
Cache =


*/
/* Based on Above values, 32768 size is breakeven for flushing/cleaning
 * full D cache
 */

I have noticed with 32KB DLIMIT, there is small reduction about 1fps in =

skiamark profile after this change. It could be because of full flush or
clean is causing more cache misses later on in the execution.

However with 64KB DLIMIT, there is further degrade in skiamark performance.
So I think 32KB is good value.

However the problems are seen in the Android UI. Small artifacts are =

seen during Video playback on UI widgets.

This artifacts are not seen if clean is called for each cpu.

Also I find it takes some effort to implement clean_all / flush_all
API's in cache-V7.S (asm) file to execute on each cpu.
And hence it was parked aside.

And I have not investigated, why flush on both cases in case of flush all on
Both cpu's always works?

Thanks & Regards
Vijay



-----Original Message-----
From: Linus Walleij [mailto:linus.walleij@linaro.org] =

Sent: Monday, June 27, 2011 5:30 PM
To: Russell King - ARM Linux; Srinidhi KASAGAR; Vijaya Kumar K-1
Cc: Per Forlin; Nicolas Pitre; Chris Ball; linaro-dev@lists.linaro.org; lin=
ux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Robert Fekete
Subject: Re: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize la=
tency

On Mon, Jun 27, 2011 at 12:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> The next thing to think about in DMA-land is whether we should total up
> the size of the SG list and choose whether to flush the individual SG
> elements or do a full cache flush. =A0There becomes a point where the full
> cache flush becomes cheaper than flushing each SG element individually.

We noticed that even for a single (large) buffer, any cache flush operation
above a certain threshold flushing indiviudal lines become more expensive
than flushing the entire cache.

I requested colleagues to look into implenting this threshold in the
arch/arm/mm/cache-v7.S file. but I think they ran into trouble and
eventually had to give up on it.

Vijay or Srinidhi, can you share your findings?

Thanks,
Linus Walleij
