From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] mmc:core: parse voltage from device-tree
Date: Tue, 30 Jul 2013 14:58:54 -0500
Message-ID: <1375214334.30721.82@snotra>
References: <1375066595-14968-1-git-send-email-Haijun.Zhang@freescale.com>
 <1375135638.30721.58@snotra> <51F71825.9000904@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <51F71825.9000904@freescale.com> (from B42677@freescale.com on
 Mon Jul 29 20:34:29 2013)
Content-Disposition: inline
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Zhang Haijun <B42677@freescale.com>
Cc: linux-mmc@vger.kernel.org, AFLEMING@freescale.com, Xie Xiaobo-R63061 <X.Xie@freescale.com>, cbouatmailru@gmail.com, cjb@laptop.org, linuxppc-dev@lists.ozlabs.org, Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: linux-mmc@vger.kernel.org

On 07/29/2013 08:34:29 PM, Zhang Haijun wrote:
> On 07/30/2013 06:07 AM, Scott Wood wrote:
>> On 07/28/2013 09:56:33 PM, Haijun Zhang wrote:
>>> Add function to support get voltage from device-tree.
>>> If there are voltage-range specified in device-tree node, this  
>>> function
>>> will parse it and return the avail voltage mask.
>>> 
>>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>>> ---
>>>  drivers/mmc/core/core.c  | 48  
>>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/mmc/core.h |  1 +
>>>  2 files changed, 49 insertions(+)
>> 
>> Move the code rather than copying it.
>> 
>> -Scott
> Hi, Scott
> 
> You mean?

The point of factoring this out is to avoid duplicating the code.  If  
you don't remove it from the place you copied it from (and have that  
code call here instead), then you're not avoiding the duplication.

-Scott
