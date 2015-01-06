From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH, RFC] MIPS: jz4740: use dma filter function
Date: Tue, 06 Jan 2015 13:51:50 +0100
Message-ID: <54ABDA66.7040002@metafoo.de>
References: <22569458.nE7JkNNnz3@wuerfel> <54ABBCE6.8060904@metafoo.de> <yw1xtx04f54r.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
        format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <yw1xtx04f54r.fsf@unicorn.mansr.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: =?windows-1252?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, linux-mmc@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-mmc@vger.kernel.org

On 01/06/2015 01:47 PM, M=E5ns Rullg=E5rd wrote:
> Lars-Peter Clausen <lars@metafoo.de> writes:
>
>> On 01/05/2015 11:39 PM, Arnd Bergmann wrote:
>>> As discussed on the topic of shmobile DMA today, jz4740 is the only
>>> user of the slave_id field in dma_slave_config besides shmobile. Th=
is
>>> use is really incompatible with the way that other drivers use the
>>> dmaengine API, so we should get rid of it.
>>
>> Do you have a link to that discussion?
>>
>>>
>>> This adds a trivial filter function that uses the filter param to
>>> pass the dma type, and uses that in both drivers.
>>
>> In my opinion that's just from bad to worse. Using filter functions
>> isn't that great in the first place. And using them to pass data fro=
m
>> the consumer to the DMA provider is just a horrible abuse of the API=
=2E
>
> It seems to me the only sane way to use the dmaengine API is in
> conjunction with DT.

At the moment yes. For non DT we need something like the gpiod lookup t=
ables=20
that allow you to specify the assignment of the DMA channel in the mach=
ine=20
driver.

- Lars
