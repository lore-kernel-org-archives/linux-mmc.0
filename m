From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH, RFC] MIPS: jz4740: use dma filter function
Date: Wed, 07 Jan 2015 17:17:51 +0100
Message-ID: <54AD5C2F.1090501@metafoo.de>
References: <22569458.nE7JkNNnz3@wuerfel> <2633187.PyovTNc8DC@wuerfel>
 <54AD42D0.4070402@metafoo.de> <10623722.YrKe6DgiSS@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <10623722.YrKe6DgiSS@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, dmaengine@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 01/07/2015 05:13 PM, Arnd Bergmann wrote:
> On Wednesday 07 January 2015 15:29:36 Lars-Peter Clausen wrote:
>> On 01/06/2015 02:48 PM, Arnd Bergmann wrote:
>>> On Tuesday 06 January 2015 11:45:58 Lars-Peter Clausen wrote:
>>>> On 01/05/2015 11:39 PM, Arnd Bergmann wrote:
>>>>> As discussed on the topic of shmobile DMA today, jz4740 is the only
>>>>> user of the slave_id field in dma_slave_config besides shmobile. This
>>>>> use is really incompatible with the way that other drivers use the
>>>>> dmaengine API, so we should get rid of it.
>>>>
>>>> Do you have a link to that discussion?
>>>
>>> http://www.spinics.net/lists/linux-mmc/msg30069.html
>>
>> I'm really not comfortable with this patch, since it is a step back. But I
>> guess the end justify the means. So if it helps to get rid of slave_id I'm
>> ok with it, sooner or later jz4740 will be converted to DT so once that's
>> done the filter function can be removed again. But please put the filter
>> function in a non arch specific header so we can still compile test things.
>> And maybe note in the commit message that this is meant as a temporary hack.
>>
>
> Do you have a timeline for DT support? Maybe it's easier to just
> wait for the problem to solve itself.

2 to 3 upstream releases. I have the code and it is working, but the 
migration path has a lot of inter dependencies between different frameworks, 
so it is going to take a while until all is upstream.

- Lars
