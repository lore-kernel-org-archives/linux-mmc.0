From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 05/19] mmc: mmci: allow to overwrite clock/power procedure
 to specific variant
Date: Wed, 11 Jul 2018 14:38:59 +0200
Message-ID: <CAPDyKFpUbHR4qfm3fDbRi=_=5oyqN9mhubySQ6a-N7msR5uU8w@mail.gmail.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
 <1528809280-31116-6-git-send-email-ludovic.Barre@st.com> <CAPDyKFpwVMX9LoC_abHm09UNhLse8MJBUpCCHkR8NnK7fOU5Yg@mail.gmail.com>
 <973d98c5-b5c7-d1c4-1b20-b6a77500adc3@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <973d98c5-b5c7-d1c4-1b20-b6a77500adc3@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic BARRE <ludovic.barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>> 2) The clock register will be written to before the regulator
>> operations have been done. Not sure if that works fine!?
>
>
> you are right, it's probably better if the clock is done after power.
> do you agree if I change the order?

If the new ST variant can cope with the existing order in the current
code, then let's stick to that to avoid breaking legacy variants.

>
>>
>> An overall comment, I think we should create a mmci_host_ops structure
>> and put the needed callbacks in there (kept to a minimum of course),
>> rather than putting them as a part of the variant struct. More
>> importantly, also the legacy mmci variants should get a mmci_host_ops
>> structure assigned during probe.
>>
>> The point is, I think it makes the code above (and future wise) more
>> flexible. It should also allow us to better share functions between
>> the variants. In principle, I expect that we end up with a bunch of
>> "library" mmci functions that can be invoked from variant's
>> mmci_host_ops (if not assigned directly).
>
>
> After "Linaro connect" we have exchanged some emails (subject: "STM32MP1
> SDMMC driver review") and the start point was
> "Goal is not to redesign mmci.c like sdhci.c."
> This it's why I'm surprise by "library" and "mmci_host_ops"
> and comment of patch 01.

Sometimes it's easier to look at patches/code, instead of giving
qualified guesses what is the best solution. Try something, realize
what is better, then try again...

The point is, we need callbacks to cope with the variants as we can't
have quirks for everything, and you are demonstrating that in $subject
patch.

Since this is the case, then I think it's better to make it more
flexible, already from the beginning and thus put the callbacks in a
new mmci host ops structure instead.

>
> So, it's not clear for me on where we wish to go.
> Could you clarify the way, if it's with a mmci_ops like sdhci_ops?

Yep, something along those lines. However, we don't want to introduce
unnecessary callbacks and complexity. We should strive towards sharing
common functionality through library functions in mmci.c, rather than
having callbacks for every single difference.

Does it makes sense?

[...]

Kind regards
Uffe
