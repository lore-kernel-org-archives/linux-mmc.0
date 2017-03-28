From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Do not hold re-tuning during CMD6 commands
Date: Tue, 28 Mar 2017 11:59:48 +0200
Message-ID: <CAPDyKFo=DwzUqFZzh0tcRiYg6GagL8VrXwpd6PyfdZ+qkYgXqw@mail.gmail.com>
References: <1490336341-22292-1-git-send-email-chaotian.jing@mediatek.com>
 <1490336341-22292-2-git-send-email-chaotian.jing@mediatek.com>
 <13a83728-0031-5683-c371-4b517df32299@intel.com>
 <1490344369.22814.10.camel@mhfsdcap03>
 <03d54000-9ced-1b31-df80-d254f02433db@intel.com>
 <1490348427.22814.19.camel@mhfsdcap03>
 <CAPDyKFoo5sJ2XtjyiW1DLjhFdJySbDK7+N05vrKpeiZsp25qrA@mail.gmail.com>
 <1490578500.22814.31.camel@mhfsdcap03>
 <CAPDyKFoWyVrdk7bG1n=rTSOddvqaj-uTO70QoGmcKQK1Fhio2w@mail.gmail.com>
 <a0df1a1d-a776-f1e6-1ee2-e66faff375d3@intel.com>
 <CAPDyKFq5st=eBW98A1VUjnGwNbocay6gf-7trcUXbUNbUThSBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFq5st=eBW98A1VUjnGwNbocay6gf-7trcUXbUNbUThSBA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: srv_heupstream <srv_heupstream@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mediatek@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

[...]

>> The retry mechanism provided by mmc_wait_for_cmd() and friends really only
>> makes sense for simple commands.  In other cases, like this, we need to
>> consider what state the card is in.  For __mmc_switch we need to consider
>> whether the card is busy or whether a timing change been made.
>
> I definitely agree. We should remove retries for CMD6 and perhaps also
> for some other cases.
>
> When we have changed the above in __mmc_switch(), the change Chaotian
> suggest gets a different impact, as it would potentially allow a
> re-tuning to happen before the next CMD1to poll for busy or to check

/s/CMD1/CMD13

> the switch status. This isn't okay.
>
> This all sounds to me that Chaotian's issue may not all be related to
> tuning, but to the CMD6 switch sequence itself. However I may be wrong
> - of course. :-)
>
> [...]
>
> Kind regards
> Uffe
