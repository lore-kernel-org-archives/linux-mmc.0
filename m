From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-iproc: Apply caps from bcm2835-mmc driver
Date: Tue, 3 Jan 2017 21:23:15 +0100 (CET)
Message-ID: <1751352115.251342.1483474996021@email.1und1.de>
References: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com>
 <1483111474-29907-2-git-send-email-stefan.wahren@i2se.com>
 <87lgusngn7.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87lgusngn7.fsf@eliezer.anholt.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gerd Hoffmann <kraxel@redhat.com>, Eric Anholt <eric@anholt.net>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 3. Januar 2017 um 19:27 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Since the mmc module on bcm2835 neither provide a capabilities register nor 
> > free documentation we must rely on the downstream implementation [1].
> 
> Yeah, caps reg is wired to 0, but it can do high speed.
> 
> Since we're VDD_330 only, I'm not sure the driver type flags do
> anything, but I'm still good with having consistency.

yes, the driver type flags currently have no benefit.

> 
> Reviewed-by: Eric Anholt <eric@anholt.net>
> 
> Interested in porting over the DMA support? :)

AFAIK the sdhci doesn't support external DMA (required for bcm2835).
So DMA support would result in a new driver, which i'm currently not interested.

But i've prepared a fixup patch series for the sdhost driver i want to send to Gerd.

> 
> I also noticed that the emmc wrapper module claims it can run with a
> clock from 50-100mhz, and the arasan says it can run at up to 50, 52, or
> 208mhz depending on SD/MMC mode.  Could we get a boost from running the
> module at a higher clock rate?

Sorry, i can't follow. Do you mean DDR mode?
