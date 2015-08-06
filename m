From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH v3 2/5] Documentation: synopsys-dw-mshc: add bindings
 for idmac and edmac
Date: Thu, 6 Aug 2015 11:13:55 +0800
Message-ID: <55C2D0F3.8000300@rock-chips.com>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
 <1438762672-22243-1-git-send-email-shawn.lin@rock-chips.com>
 <CAD=FV=Wv1FLHGyK=yL_P-WbRZwnK2K-rMEaXHjsZf+4iHfucjw@mail.gmail.com>
 <55C2C453.3000005@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
        format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <55C2C453.3000005@samsung.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Jaehoon Chung <jh80.chung@samsung.com>, Doug Anderson <dianders@chromium.org>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexey Brodkin <abrodkin@synopsys.com>, Stefan Agner <stefan@agner.ch>, Zhou Wang <wangzhou.bry@gmail.com>, Kumar Gala <galak@codeaurora.org>, Alim Akhtar <alim.akhtar@samsung.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Wang Long <long.wanglong@huawei.com>, Rob Herring <robh+dt@kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Lukasz Majewski <l.majewski@samsung.com>, Jun Nie <jun.nie@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Kevin Hao <haokexin@gmail.com>, Olof Johansson <olof@lixom.net>, Ray Jui <rjui@broa>
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2015/8/6 10:20, Jaehoon Chung =E5=86=99=E9=81=93:
> On 08/06/2015 11:16 AM, Doug Anderson wrote:
>> Shawn,
>>
>> On Wed, Aug 5, 2015 at 1:17 AM, Shawn Lin <shawn.lin@rock-chips.com>=
 wrote:
>>> synopsys-dw-mshc supports three types of transfer mode. We add bind=
ings
>>> and description for how to use them at runtime. Without idmac and e=
dmac
>>> property, pio is the default transfer mode. Make sure that Idmac an=
d emdac
>>> should not be used simultaneously.
>> Can't you just read the HCON register?
>>
>> [17:16]: DMA_INTERFACE
>>   00: none
>>   01: DW_DMA
>>   10: GENERIC_DMA
>>   11: NON-DW-DMA
> If read it and get the exactly information. I think we can use that i=
nformation.

  It's helpful really, but the description is ambiguous. =EF=BC=9A(
  So I make a big big mistake when I read it for the firest time .
  I was just wondering the "mismatch" value from HCON and my databook.

Here I get details from our ASIC team guy :

// Name:         DMA_INTERFACE
// Default:      None
// Values:       None (0), DW-DMA (1), Generic-DMA (2), NON-DW-DMA (3)
// Enabled:      INTERNAL_DMAC=3D=3D0
//
// Configures the type for DMA interface. In addition to AMBA host=20
interface,
//  the data FIFO can be accesses by the optional DMA interface. The DM=
A=20
type
//  could be either DW-DMA, which provides hand shake signals to=20
DW_ahb_dmac
//  controller, or a generic DMA interface which provides a simpler
//  request/acknowledgement protocol and dedicated DMA data-bus, or
//  no DMA interface.
`define DMA_INTERFACE 1

   if we use idmac, DMA_INTERFACE should be "0", and we get 2b'00 from=20
HCON[17:16]
   if we use edmac, DMA_INTERFACE should be "1", "2" and we get 2b'01 ,=
2b'10
   from HCON[17:16] respectively .
   But if only support PIO mode,   DMA_INTERFACE should be "3", and we=20
get 2b'11 from
   HCON[17:16].

   So, "none" means IDMAC, "DW_DMA"/"GENERIC_DMA" refer to two types of=
=20
external dma and "NON-DW-DMA" means pio from databook . It's a little=20
difficult to understand it.

  This makes my work easy!

  Thanks, Doug and Jeahoon.

> Best Regards,
> Jaehoon Chung
>
>
>
>


--=20
Shawn Lin
