From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCHv3 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Fri, 1 Jul 2011 21:35:27 +0530
Message-ID: <BANLkTikRkZkSw_dj=GTnrGEmFwgsbG2usQ@mail.gmail.com>
References: <1309460700-25898-1-git-send-email-balajitk@ti.com>
	<1309460700-25898-3-git-send-email-balajitk@ti.com>
	<87d3hudhun.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:33625 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751788Ab1GAQFb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Jul 2011 12:05:31 -0400
In-Reply-To: <87d3hudhun.fsf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, b-cousson@ti.com, paul@pwsan.com, kishore.kadiyala@ti.com

On Fri, Jul 1, 2011 at 4:53 AM, Kevin Hilman <khilman@ti.com> wrote:
> Balaji T K <balajitk@ti.com> writes:
>
>> +static int omap_hsmmc_runtime_resume(struct device *dev)
>> +{
>> + =A0 =A0 struct omap_hsmmc_host *host;
>> +
>> + =A0 =A0 host =3D platform_get_drvdata(to_platform_device(dev));
>> + =A0 =A0 omap_hsmmc_context_restore(host);
>> + =A0 =A0 dev_dbg(mmc_dev(host->mmc), "host: enabled\n");
>
> Minor: this has a 'host: ' prefix, where as the one in
> .runtime_suspend() does not.

=46ixing it in V4

>
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>
> Kevin
>
