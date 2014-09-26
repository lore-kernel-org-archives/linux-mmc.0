From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v3 00/12] clk: sunxi: Improve MMC clocks support
Date: Thu, 25 Sep 2014 17:42:18 -0700
Message-ID: <20140926004218.19023.88602@quantum>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140922113133.GF15315@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140922113133.GF15315@lukather>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, Emilio Lopez <emilio@elopez.com.ar>, linux-mmc@vger.kernel.org, chris@printf.net, Hans de Goede <hdegoede@redhat.com>, wens@csie.org, david.lanzendoerfer@o2s.ch, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Quoting Maxime Ripard (2014-09-22 04:31:33)
> Mike,
> 
> On Thu, Sep 11, 2014 at 10:18:14PM +0200, Maxime Ripard wrote:
> > Hi everyone,
> > 
> > Here is an attempt at improving the MMC clock support in the Allwinner
> > SoCs.
> > 
> > Until now, the MMC clocks were having a custom phase function that was
> > directly setting an obscure value in the right register, because we
> > were not really having any idea of what these values were.
> > 
> > Now that we have more informations, we can introduce a common function
> > call to get and set the phase of a particular clock, and use this in
> > both our provider and our client.
> 
> It would be great that we have that custom phase API out of the kernel
> for 3.18, and you were one of the greatest supporters to that idea,
> could we please have your view on this?

Patches all look good to me. Did you want the whole series to go through
the clk tree? If so we'll need an Ack for the MMC patch and for the ARM
DTS patches as well.

Regards,
Mike

> 
> Thanks,
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
