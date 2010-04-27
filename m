From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/4] MMC: atmel-mci: fix two parameters swapped
Date: Tue, 27 Apr 2010 17:34:00 +0200
Message-ID: <4BD703E8.4080307@atmel.com>
References: <1271671952-29204-1-git-send-email-nicolas.ferre@atmel.com>
	<bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>
	<4BD70251.9060501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4BD70251.9060501@ru.mvista.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: kernel@avr32linux.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, haavard.skinnemoen@atmel.com, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Le 27/04/2010 17:27, Sergei Shtylyov :
> Hello.
> 
> Nicolas Ferre wrote:
> 
>> Two parameters were swapped in the calls to atmci_init_slot(). Two
>> parameters
>> were swapped in the calls to atmci_init_slot().
> 
>  The same sentence is repeated twice.
> 
>>  Their values
>>   
> 
>   ???

indeed! I reposted a new patch message.

Sorry for the noise.

Best regards,
-- 
Nicolas Ferre
