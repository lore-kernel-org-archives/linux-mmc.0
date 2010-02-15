From: "Linus Walleij" <linus.walleij@stericsson.com>
Subject: RE: [PATCH 3/3] [U300] Set f_max to 24 MHz for MMC
Date: Mon, 15 Feb 2010 14:04:07 +0100
Message-ID: <A6D19A13FE030A409EC4362C172E091F0E84AFAD@eseldmw101.eemea.ericsson.se>
References: <1266233040-17124-1-git-send-email-linus.walleij@stericsson.com>
	<4B7936CE.9020402@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-class: urn:content-classes:message
In-Reply-To: <4B7936CE.9020402@csr.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

[David Vrabel]

> Linus Walleij wrote:
> > 
> > +	mmci_card->mmc0_plat_data.f_max = 24*1024*1024;
> 
> Is the frequency really 25165824 Hz and not 24000000 Hz?

It's actually 18900000 Hz. This f_max is a physical
limitation and a property of the SoC, so that figure
comes from some semiconductor person.

When combined with the U300 clock framework, the
min() function will resolve to min(18900000, 24000000)
i.e. 18900000 Hz.

Linus Walleij
