From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH v2 3/5] ARM: mvebu: set SW polling as SDHCI card detection
 on A388-GP
Date: Fri, 9 Oct 2015 12:16:39 +0200
Message-ID: <CAPv3WKcy4iDwcLoeu8zn1CVDJrwcRsXFHBjEt60Bi9F9q8JXzQ@mail.gmail.com>
References: <1444352635-21965-1-git-send-email-mw@semihalf.com>
	<1444352635-21965-4-git-send-email-mw@semihalf.com>
	<20151009095204.41010dd9@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151009095204.41010dd9@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, =?UTF-8?Q?Gregory_Cl=C3=A9ment?= <gregory.clement@free-electrons.com>, nadavh@marvell.com, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Grzegorz Jaszczyk <jaz@semihalf.com>
List-Id: linux-mmc@vger.kernel.org

Hi Thomas,


2015-10-09 9:52 GMT+02:00 Thomas Petazzoni
<thomas.petazzoni@free-electrons.com>:
> Dear Marcin Wojtas,
>
> On Fri,  9 Oct 2015 03:03:53 +0200, Marcin Wojtas wrote:
>> The newest revisions of A388-GP (v1.5 and higher) support only
>> DAT3-based card detection. Revisions < v1.5 based on GPIO detection
>> via I2C expander, but this solution is supposed to be deprecated on
>> new boards. In order to satisfy all type of hardware this commit
>> changes card detection to use software polling mechanism.
>>
>> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>
> Can we add a comment on the DT that explains why SW polling is used,
> and which other mechanism can be used depending on the board revision?

Sure, good idea. Do you think the below would be sufficient?
sdhci@d8000 {
    pinctrl-names = "default";
    pinctrl-0 = <&sdhci_pins>;
    no-1-8-v;
    /*
     * A388-GP board v1.5 and higher replace
     * hitherto card detection method based on GPIO
     * with the one using DAT3 pin. As they are
     * incompatible, software-based polling is
     * enabled with 'broken-cd' property. For boards
     * older than v1.5 it can be replaced with:
     * 'cd-gpios = <&expander0 5 GPIO_ACTIVE_LOW>;',
     * whereas for the newer ones following can be
     * used instead:
     * 'dat3-cd;'
     * 'cd-inverted;'
     */
broken-cd;
wp-inverted;
bus-width = <8>;
status = "okay";
};

Best regards,
Marcin
