From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: Add device tree support
Date: Thu, 16 Aug 2012 23:57:30 +0530
Message-ID: <CAJuYYwQ++jWQ1ca=EKY+G5Bs+otOOe6gBoiaNhsJY6G0YdHU8Q@mail.gmail.com>
References: <CAJuYYwQjN9UtXcfjNXf1Ezw3igfUSQDNEP8X038L4=br6EROUA@mail.gmail.com>
	<1345134914-21635-1-git-send-email-thomas.abraham@linaro.org>
	<87fw7mdbj2.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <87fw7mdbj2.fsf@octavius.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 16 August 2012 22:22, Chris Ball <cjb@laptop.org> wrote:
> Hi Thomas,
>
> On Thu, Aug 16 2012, Thomas Abraham wrote:
>> +Optional Board Specific Properties:
>> +- One of the following properties for card detect type.
>> +  - samsung,sdhci-cd-internal: Card detect line from the card slot is
>> +    connected to the card detect pad of the sdhci controller. A gpio is
>> +    used for this connection (with possible pin function settings).
>> +  - samsung,sdhci-cd-gpio: A gpio line (with possible pin function settings)
>> +    is used a card detect line. This gpio line is not connected to card detect
>> +    pad of the sdhci controller.
>> +  - samsung,sdhci-cd-none: There is no card detect line. Polling is used to
>> +    detect the presence of the card. (DEFAULT, if no card detect property
>> +    is specified).
>> +  - samsung,sdhci-cd-permanent: There is no card detect line. The card is
>> +    permanently connected to the sdhci controller.
>
> sdhci-s3c isn't the only driver that's going to have options for
> different cd configurations -- maybe now is the right time to move
> these options into the core bindings?

Yes, I agree. It will be better to reduce the custom bindings.

>
> At OLPC we've just started using:
>
>  * "broken-cd" to mean "samsung,sdhci-cd-none",

Yes, they are mean the same.

>
>  * the presence of a "cd-gpios" property to imply "samsung,sdhci-cd-gpio".

"samsung,sdhci-cd-gpio" and "sdhci-cd-internal" both use the cd-gpio line.

"samsung,sdhci-cd-gpio" means that the cd-gpio line is not connected
to the card-detect pad of the sdhci controller. Instead, it identifies
cd-gpio as a gpio pin, connected to the card-detect pin of the "card
slot" and it can used as a source of external interrupt. The driver
can register card insert/remove handler for this interrupt and get
notified about the changes in card state.

"sdhci-cd-internal" means that the "cd-gpio" line is used to connect
the card-detect pin of the card slot and the card-detect pad of the
sdhci controller. The controller is then aware of any changes in card
state and the controller generates appropriate interrupts to notify
changes in card-state.

>
>  * "non-removable" to mean "samsung,sdhci-cd-permanent" (this is already
>    specified in mmc.txt)

Ok.

>
> Would these work for you?

Yes, the first and the third works, but the second point needs a way
to identify the type of external card-detection mechanism.

>
> We don't have a distinction between sdhci-cd-internal and sdhci-cd-gpio,
> and I'm having trouble working out why one is necessary.  Why does the
> driver need to know where the gpio came from, aside from knowing which
> gpio it is and whether it needs to be inverted (with cd-inverted)?

This is as explained above. Maybe other controllers also need
something similar to "samsung,sdhci-cd-gpio" and "sdhci-cd-internal".
And so, we could make a generic binding for these as well.

Thanks,
Thomas.
