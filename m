From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 12/18] pinctrl: bcm2835: Add support for BCM2711 pull-up
 functionality
Date: Sun, 11 Aug 2019 22:15:57 +0200
Message-ID: <63f17284-5551-9492-9eff-f8a4c003196b@gmx.net>
References: <1563776607-8368-1-git-send-email-wahrenst@gmx.net>
 <1563776607-8368-3-git-send-email-wahrenst@gmx.net>
 <CACRpkdabfiDbGmAQciAUSThY-KfTsVq3tHz0bBszs2j_ej18Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdabfiDbGmAQciAUSThY-KfTsVq3tHz0bBszs2j_ej18Nw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <mbrugger@suse.com>, Scott Branden <sbranden@broadcom.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>, Michael Turquette <mturquette@baylibre.com>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Am 05.08.19 um 11:38 schrieb Linus Walleij:
> On Mon, Jul 22, 2019 at 8:24 AM Stefan Wahren <wahrenst@gmx.net> wrote:
>
>> The BCM2711 has a new way of selecting the pull-up/pull-down setting
>> for a GPIO pin. The registers used for the BCM2835, GP_PUD and
>> GP_PUDCLKn0, are no longer connected. A new set of registers,
>> GP_GPIO_PUP_PDN_CNTRL_REGx must be used. This commit will add
>> a new compatible string "brcm,bcm2711-gpio" and the kernel
>> driver will use it to select which method is used to select
>> pull-up/pull-down.
>>
>> This patch based on a patch by Al Cooper which was intended for the
>> BCM7211. This is a bugfixed and improved version.
>>
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Patch applied.
Thanks
>
> I think I complained about some other version of this patch, this one
> looks entirely acceptable.
>
> Can we get rid of custom pull settings etc from the upstream device
> trees so we don't set bad examples? I have a strong urge to
> throw in a pr_warn() about any use of it.

Ironically, my pre-RFC version tried to convert all BCM2835 pinmux
settings to generic ones. Unfortunately it seems that i made a mistake,
because it didn't work as expected. Since we stumpled above more and
more other issues (not relevant to pinctrl) during upstream review, i
decided to start with legacy pull-up support, so we can fix this later
in the devicetree for both platforms (currently BCM2711 uses most of the
old BCM2835 pinmuxes including the legacy stuff). So yes my plan is to
fix this soon.

Stefan

>
> Yours,
> Linus Walleij
