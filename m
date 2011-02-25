From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH v4 0/6] OMAP: HSMMC: hwmod adaptation
Date: Fri, 25 Feb 2011 18:36:42 +0530
Message-ID: <AANLkTim=g6a-nq-J4wmaqZWSgR9OmaQMi=KUkXmfPAHJ@mail.gmail.com>
References: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com> <4D67A677.4000407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4D67A677.4000407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "cjb@laptop.org" <cjb@laptop.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>
List-Id: linux-mmc@vger.kernel.org

Hi Benoit,

On Fri, Feb 25, 2011 at 6:24 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> Hi Kishore,
>
> On 2/24/2011 8:26 PM, Kadiyala, Kishore wrote:
>>
>> Adding hwmod data for hsmmc device on OMAP2430/OMAP3/OMAP4.
>> Adapting the omap_hsmmc driver to hwmod framework.
>>
>> The patch series is based on omap-for-linus and tested on
>> OMAP2430, OMAP3430SDP& =A0OMAP4430SDP.
>> Also boot tested on OMAP2420SDP.
>>
>> V4:
>> ---
>> Omap2420 platform consists of mmc block as in omap1 and not the
>> hsmmc block as present in omap2430, omap3, omap4 platforms.
>> The series takes care of hwmod adaptation of hsmmc drivers and
>> thus excluding the omap2420 platforms.
>>
>> Also includes renaming of device& =A0driver name.
>>
>> The patch series has dependency on :
>> =A01)https://patchwork.kernel.org/patch/585281/
>> =A02)https://patchwork.kernel.org/patch/538301/
>
> This is still not omap-for-linus (at 7cab871)...
> I cannot apply the series on it:-(

The patch series has dependency on
link (1)  mentioned above [Opening link is throwing error] ,
below is the new link
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg45190.html

Could you please check once.

<snip>

Regards,
Kishore
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
