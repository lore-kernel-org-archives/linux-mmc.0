From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/4] dt-bindings: Add binding for brcm,bcm2835-sdhost.
Date: Tue, 31 Jan 2017 09:10:34 +0100
Message-ID: <1485850234.23903.18.camel@redhat.com>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
 <1485516989-1072-2-git-send-email-kraxel@redhat.com>
 <2012885435.15821.1485812279271@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2012885435.15821.1485812279271@email.1und1.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, f.fainelli@gmail.com, sbranden@broadcom.com, rjui@broadcom.com, lee@kernel.org, linux-mmc@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mo, 2017-01-30 at 22:37 +0100, Stefan Wahren wrote:
> > Gerd Hoffmann <kraxel@redhat.com> hat am 27. Januar 2017 um 12:36 geschrieben:
> > 
> > 
> > From: Eric Anholt <eric@anholt.net>
> > 
> > This is the other SD controller on the platform, which can be swapped
> > to the role of SD card host using pin muxing.
> 
> AFAIK the SDHOST controller isn't able to handle SDIO. Maybe we should
> mention this in the binding document.

Hmm, I think the driver commit message and the Kconfig help text are
better places for that.

cheers,
  Gerd
