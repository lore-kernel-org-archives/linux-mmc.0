From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/4] mmc: bcm2835: Add new driver for the internal SD
 controller.
Date: Fri, 27 Jan 2017 16:27:25 +0100
Message-ID: <CAPDyKFoWyZaRLhuBnFfJupxRnUvq-JWczS7ObjAGat056MCEyw@mail.gmail.com>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
 <1485516989-1072-3-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1485516989-1072-3-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Ray Jui <rjui@broadcom.com>, Lee Jones <lee@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux@armlinux.org.uk, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 27 January 2017 at 12:36, Gerd Hoffmann <kraxel@redhat.com> wrote:
> From: Eric Anholt <eric@anholt.net>
>
> The 2835 has two SD controllers:  The Arasan SDHCI controller (supported
> by the iproc driver) and a custom SD controller.  This patch adds a
> driver for the custom SD controller.
>
> The custom controller runs faster, and driving the sdcard with the
> custom controller also allows to drive the rpi3 wifi with the iproc
> driver.
>

I don't understand this relationship. Is this somewhat configurable in runtime?

Is the WIFI module a removable SDIO card? So you can decide which
controller that is best suited to use? No?

Kind regards
Uffe
