From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
Date: Tue, 2 Mar 2010 15:29:33 -0800
Message-ID: <5e088bd91003021529u23bf4fc7n22c04086b0323c2e@mail.gmail.com>
References: <cover.1265801967.git.david.vrabel@csr.com>
	 <004901cab001$6b19f6c0$544ff780@am.dhcp.ti.com>
	 <4B7C4608.5010008@csr.com>
	 <alpine.DEB.2.00.1002171254040.24812@utopia.booyaka.com>
	 <4B7D3EAE.1010908@csr.com>
	 <alpine.DEB.2.00.1002180951330.24812@utopia.booyaka.com>
	 <004001cab0c9$b208b2b0$544ff780@am.dhcp.ti.com>
	 <alpine.DEB.2.00.1002181231520.24812@utopia.booyaka.com>
	 <5e088bd91002181416l33dc2fe4u8d2a09d12ea0344e@mail.gmail.com>
	 <00cf01caba54$f39dba60$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <00cf01caba54$f39dba60$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, David Vrabel <david.vrabel@csr.com>, r-woodruff2@ti.com, sawant@ti.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Mar 2, 2010 at 2:08 PM, Madhusudhan <madhu.cr@ti.com> wrote:

>> That is correct, a Wi2Wi wifi module is connected via mmc2 on the
>> Overo Air and Fire products.

> A dumb question. Is this Wi2Wi wifi module available as a standard SDIO card
> which can be plugged into a SD card cage? Or is it specifically designed for
> the gumstix board?

The module on Overo is soldered directly to the board. It is a
standard part, not custom.  I am not aware if wi2wi also sells a SD
version.

Steve
