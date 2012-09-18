From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Date: Tue, 18 Sep 2012 01:07:58 -0400
Message-ID: <m3haqvlxzl.fsf@pullcord.laptop.org>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <20120911075429.GA27028@lizard> <20120911080457.GA28235@lizard>
 <110EED8CC96DFC488B7E717A2027A27C176170@039-SN1MPN1-002.039d.mgd.msft.net>
 <6D8C87BA-CA06-4215-94F5-63EBF5162B0A@kernel.crashing.org>
 <2A6FCAE3-288F-4972-90C0-15105932F13E@kernel.crashing.org>
 <87k3w0y5yn.fsf@octavius.laptop.org>
 <FC22FA36-B2CF-49C2-A0B1-8A0EA614B9CB@kernel.crashing.org>
 <8B1F0805-759E-417A-B787-40DF197896F3@kernel.crashing.org>
 <110EED8CC96DFC488B7E717A2027A27C1785D0@039-SN1MPN1-002.039d.mgd.msft.net>
 <4E15F856-D385-40C4-A5FD-5F298C70F402@kernel.crashing.org>
 <m3k3vsn7wf.fsf@pullcord.laptop.org>
 <1166FFD6-342F-4BDA-BF23-794DAEA95CC9@kernel.crashing.org>
 <110EED8CC96DFC488B7E717A2027A27C17DBCA@039-SN1MPN1-002.039d.mgd.msft.net>
 <02298E64-619A-4F41-A329-5FA3C909B224@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <02298E64-619A-4F41-A329-5FA3C909B224@kernel.crashing.org> (Kumar
 Gala's message of "Tue, 18 Sep 2012 00:00:55 -0500")
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
To: Kumar Gala <galak@kernel.crashing.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Huang Changming-R66093 <R66093@freescale.com>, "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>, Anton Vorontsov <cbouatmailru@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Sep 18 2012, Kumar Gala wrote:
>>>> I've got a mild preference for handling quirk assignment in the DT
>>>> rather than in driver code, so I'd prefer to just push the original
>>>> patch to mmc-next as-is.  Does that sound okay?
>>> 
>>> Why?  I only ask because I agree with Scott that this means you have to
>>> update your device tree to get proper functionality.
>>> 
>> When the new silicon does not support CMD23,
>> if we don't update the device tree, then we must update the SDHC driver.
>> I prefer to add the property in device tree,
>> because we just add this property in new device tree, we don't need more effort to modify driver.
>
> Jerry,
>
> I think doing it driver makes more sense because:
>
> 1. means older device tree's still work
> 2. odds that CMD23 not being supported in future devices is near 0%
>    (Now that we support AutoCMD23 [and thus CMD23] we aren't likely to stop supporting it in future)
> 3. If IP changes you are going to have to update driver anyways for new features
>
> I really think we should NOT utilize device tree for this.

Of course, we could also make both (or perhaps neither) of you happy by
merging both:  if your DT says you don't support cmd23 *or* you hit the
driver's blacklist, we avoid it.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
