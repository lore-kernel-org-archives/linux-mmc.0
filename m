From: Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: Re: MMC: bonnie++ runs with errors after switching mmc to blk-mq
Date: Tue, 13 Nov 2018 16:45:55 +0000
Message-ID: <1542127554.10282.27.camel@synopsys.com>
References: <1541774198.20621.50.camel@synopsys.com>
 <CACRpkdYL3NTmQieC025W=Qh515U-+75dD_39vQkZYsvuLc8Vvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdYL3NTmQieC025W=Qh515U-+75dD_39vQkZYsvuLc8Vvw@mail.gmail.com>
Content-Language: en-US
Content-ID: <C8E265BE966CD747A097FEC9FDA9F2B5@internal.synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: "eugeniy.paltsev@synopsys.com" <eugeniy.paltsev@synopsys.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "paolo.valente@linaro.org" <paolo.valente@linaro.org>, Vineet Gupta <vineet.gupta1@synopsys.com>, "alexey.brodkin@synopsys.com" <alexey.brodkin@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 2018-11-13 at 09:09 +0100, Linus Walleij wrote:
> On Fri, Nov 9, 2018 at 3:36 PM Eugeniy Paltsev
> <eugeniy.paltsev@synopsys.com> wrote:
> 
> > I still can reproduce errors about hung task when I run bonnie++ benchmark on arc/hsdk board
> > (ARC HS38 CPU, Synopsys DW MMC controller).
> 
> Hm I didn't use bonnie++ but I used iozone excessively to verify
> Adrians patches, at times leaving it running for days without
> any problems. (Though not on these hardwares.)
> 
> > Error message
> > is like:
> > ----------------------------->8----------------------------
> > # mount /dev/mmcblk0p4 /mnt/mmcblk0p4
> > EXT4-fs (mmcblk0p4): mounted filesystem with
> > ordered data mode. Opts: (null)
> > # bonnie++ -u root -r 256 -s 512 -x 1  -d /mnt/mmcblk0p4
> > Using uid:0, gid:0.
> > Writing with putc()...done
> > Writing
> > intelligently...done
> > Rewriting...INFO: task bonnie++:187 blocked for more than 10 seconds.
> >       Not tainted 4.19.0 #2
> 
> I'm not sure hanging for more than 10 seconds is really a
> problem. eMMCs can sometimes become really slow
> when doing internal garbage collection. Are you sure
> this is not the case?

Actually I'm not an expert in eMMC stuff so it's 
difficult to me to talk about eMMCs internal garbage collection.

>  If you run it without the hang checks,
> will it still complete, or is this one of those benchmarks
> that just keep running until you interrupt it?

bonnie++ completes regardless of hung tasks detection enabling/disabling.

Nevertheless as I can see write speed differs significantly in
case of clean run and run with hung task notifications
(look at shrinked bonnie++ output bellow)

Moreover I launched bonnie++ on kernel build from commit c3d53d0da69d
[one commit behind 81196976ed94 (mmc: block: Add blk-mq support)]
and I don't see significant differs in write speed values between
multiple bonnie++ runs. (There is no hung task notifications as well)


Good case (ARM, CubieBoard2):
------Sequential Output------
-Per Chr-|--Block--|-Rewrite-
K/sec %CP|K/sec %CP|K/sec %CP
 5825  98|12996   7| 9873   5


Bad (with hung task notification) case (ARM, CubieBoard2):
------Sequential Output------
-Per Chr-|--Block--|-Rewrite-
K/sec %CP|K/sec %CP|K/sec %CP
 5630  95| 6275   3| 4723   2


> > (filemap_fdatawait_keep_errors) from
> > [<c02cc3d0>] (jbd2_journal_commit_transaction+0x9b8/0x167c)
> > [ 6402.570857] [<c02cc3d0>]
> > (jbd2_journal_commit_transaction) from [<c02d0478>] (kjournald2+0xe4/0x2c8)
> > [ 6402.580011] [<c02d0478>] (kjournald2) from [<c013ab04>]
> 
> This seems more like some excessive wait in the file system
> journal to me (OK I might be wrong). Which is also known
> to thrash the specific sectors where the journal is kept
> which may very well lead to a lot of garbage collection
> in the card. (OK I am half-guessing...)
> 
> What filesystem are you using on this eMMC?

I use ext4 in both of cases.

> If something exotic, could you just try ext4 as most
> embedded systems use and see what happens?
> 
> Yours,
> Linus Walleij
-- 
 Eugeniy Paltsev
