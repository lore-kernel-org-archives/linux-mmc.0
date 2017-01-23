From: Matt Ranostay <matt@ranostay.consulting>
Subject: Re: [PATCH v3 1/2] devicetree: document new marvell-8xxx and
 pwrseq-sd8787 options
Date: Mon, 23 Jan 2017 13:00:21 -0800
Message-ID: <CAJ_EiST4286EbMKDP3qVpYRw+i9L0aJUj40wQ3K8JhsvcQETZw@mail.gmail.com>
References: <20170121055039.10924-1-matt@ranostay.consulting>
 <20170121055039.10924-2-matt@ranostay.consulting> <20170123170409.rnmnf4ssjpd2yk3l@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35891 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdAWVAX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jan 2017 16:00:23 -0500
Received: by mail-qt0-f170.google.com with SMTP id k15so146539403qtg.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2017 13:00:22 -0800 (PST)
In-Reply-To: <20170123170409.rnmnf4ssjpd2yk3l@rob-hp-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-mmc@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org

On Mon, Jan 23, 2017 at 9:04 AM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Jan 20, 2017 at 09:50:38PM -0800, Matt Ranostay wrote:
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> ---
>>  .../devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt          | 14 ++++++++++++++
>>  .../devicetree/bindings/net/wireless/marvell-8xxx.txt      |  7 ++++++-
>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
>> new file mode 100644
>> index 000000000000..4bb56766982e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
>> @@ -0,0 +1,14 @@
>> +* Marvell SD8787 power sequence provider
>> +
>> +Required properties:
>> +- compatible: must be "mmc-pwrseq-sd8787".
>> +- powerdown-gpio: contains a power down GPIO specifier with active state
>> +- reset-gpio: contains a reset GPIO specifier with active state
>
> My comments on the previous v3 still apply.

Ah yikes.. forgot to increment the patchset.  And noticed the gpio
isn't gpios... will fixed in "v4"

Thanks,

Matt

>
>> +
>> +Example:
>> +
>> +     wifi_pwrseq: wifi_pwrseq {
>> +             compatible = "mmc-pwrseq-sd8787";
>> +             powerdown-gpio = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
>> +             reset-gpio = <&twl_gpio 1 GPIO_ACTIVE_LOW>;
>> +     }
