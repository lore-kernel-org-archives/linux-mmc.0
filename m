From: Arend van Spriel <arend@broadcom.com>
Subject: Re: [RFC] dt: bindings: add bindings for Broadcom bcm43xx sdio devices
Date: Sun, 30 Mar 2014 10:56:14 +0200
Message-ID: <5337DC2E.5040000@broadcom.com>
References: <1392059868-8782-1-git-send-email-arend@broadcom.com> <52FC8CB3.4090305@gmail.com> <CAGb2v67za+5yW3RE0pwBWk-NdTUSm-JkKE+j9NLjbBkE_Fc1hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGb2v67za+5yW3RE0pwBWk-NdTUSm-JkKE+j9NLjbBkE_Fc1hQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 02/13/14 10:28, Chen-Yu Tsai wrote:
> Hi,
>
> On Thu, Feb 13, 2014 at 5:13 PM, Tomasz Figa<tomasz.figa@gmail.com>  wrote:
>> Hi Arend,
>>
>>
>> On 10.02.2014 20:17, Arend van Spriel wrote:

[...]

>>> +
>>> +Example:
>>> +
>>> +mmc3: mmc@01c20000 {
>>> +       pinctrl-0 =<&mmc3_pins>;
>>> +       pinctrl-1 =<&wifi_host_wake>;
>>
>>
>> WLAN_HOST_WAKE pin (aka the OOB interrupt) is specific to the WLAN chip, so
>> this should be rather configured in a pinctrl state of the WLAN chip itself.

Hi Chen-Yu,

picking up this thread.

> AFAIK, the pinctrl in tied to the device node, and is selected when the device
> is registered. The MMC subsystem currently does not register child nodes, so
> this would be useless.

So if MMC does not register child nodes, brcmfmac will not be probed 
with of_node set? Have there been patches submitted for this in mmc 
subsystem recently.

> brcmfmac actually has to walk the whole DT to find the node with the right
> compatible.

Is it just me or should this be avoided? What if there are multiple entries?

Regards,
Arend
