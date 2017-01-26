From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 01/13] mmc: bcm2835: add bcm2835_read_wait_sdcmd
Date: Thu, 26 Jan 2017 15:51:00 -0800
Message-ID: <30bf98f0-c893-d306-ab79-3ba741790919@gmail.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
 <1485473846-24537-2-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485473846-24537-2-git-send-email-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>, linux-rpi-kernel@lists.infradead.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 01/26/2017 03:37 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Few things with your submission:

- if you send more than one patch, a cover letter is a welcome to
explain your changes

- try to provide commit messages for things that are not obvious (in
fact, most maintainers actually request commit messages even for trivial
things)

- have not we switched to the iproc SDHCI driver, or is this for the
other SDIO connected peripherals here?

Thanks
-- 
Florian
