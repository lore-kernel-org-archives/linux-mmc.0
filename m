From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 05/18] ARM: dts: bcm283x: Define memory at board level
Date: Mon, 12 Aug 2019 23:02:44 +0200
Message-ID: <22482ae9-0239-560e-ad4a-4ab13d864e15@gmx.net>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
 <1563774880-8061-6-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563774880-8061-6-git-send-email-wahrenst@gmx.net>
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
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-mmc@vger.kernel.org

Am 22.07.19 um 07:54 schrieb Stefan Wahren:
> Now with the varity of several RPi boards, the memory should be defined
> at board level. This step gives us the chance to fix the memory size
> of the RPi 1 B+, Zero (incl. W) and Compute Module 1.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Applied to bcm2835-dt-next
