From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] mmc: debugfs: parse all ext_csd via debug_fs
Date: Wed, 26 Oct 2011 13:27:56 +0200
Message-ID: <4EA7EEBC.2070109@st.com>
References: <1319468694-8773-1-git-send-email-peppe.cavallaro@st.com> <CAAgDR1N_CKnXo=G2oTHAShhgegMZF-nMySBuWebDPeu8VTEBKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:38740 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932673Ab1JZL2A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2011 07:28:00 -0400
In-Reply-To: <CAAgDR1N_CKnXo=G2oTHAShhgegMZF-nMySBuWebDPeu8VTEBKg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Rasmussen <sebras@gmail.com>
Cc: linux-mmc@vger.kernel.org

On 10/25/2011 1:43 PM, Sebastian Rasmussen wrote:
>> This patch enhances the debug information reported
>> for the mmc card by parsing the extended CSD registers
>> obviously according to all the current specifications.
> 
> Does this belong kernel or in userspace? I'm not sure, and
> I'm hoping that any of the old-timers here chime in on it.
> Anyway I supply you with a few comments on you patch
> below...
> 

This is on kernel space. Before the patch the output from
/sys/kernel/debug/mmc0/mmc0:0001/ext_csd
was a big number and I had many problems parsing it in real-time.
Maybe, there is some user-space application to do this job that I do not
know. :-(
In any case, the patch wants to help to directly get the ext_csd in a
human format.

> BTW, you are parsing EXT_CSD here, but then one really
> should expand CSD, SCR, CID as well. One of those

Yes we could parse CID and CSD too.
I guess in another patch.
Please consider this patch for the ext_csd entry in /sys.

> contains a numerical customer id which leads me to believe
> that it would require some kind of list of number->name to
> make it accessible to users, something akin to the lspci
> database. I did write an initial draft of such a userspace tool
> at my old employers over at ST-Ericsson and tried to open
> source it just before I resigned, but I don't know whether it
> has made it through the legal barrier yet. I'll let you know
> if I see it.

Yes let me know.

Thanks for the reviewing. I'll look and fix all the points below and
resend the patch again.

Peppe

> 
>> I have no HW to test eMMC 4.5 at this moment. In any case,
>> the patch supports JEDEC Standard No. 84-B45.
>> No issues on JESD84-A441 and older specs raised on my side.
>>
>> Output from /sys/kernel/debug/mmc0/mmc0:0001/ext_csd
>> looks like this:
>>
>>  Extended CSD rev 1.5 (MMC 4.41)
>>  s_cmd_set: 0x01
>>  hpi_features: 0x00
>>  blops_support: 0x00
>>  ini_timeout_ap: 0x0a
>>  pwr_cl_ddr_52_360 0x00
>>  [snip]
>>
>> Reported-by: Youssef Triki <youssef.triki@st.com>
>> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>> ---
>>  drivers/mmc/core/debugfs.c |  266 ++++++++++++++++++++++++++++++++++++++------
>>  1 files changed, 232 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>> index 0b9a4aa..3771624 100644
>> --- a/drivers/mmc/core/debugfs.c
>> +++ b/drivers/mmc/core/debugfs.c
>> @@ -223,19 +223,13 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
>>  DEFINE_SIMPLE_ATTRIBUTE(mmc_dbg_card_status_fops, mmc_dbg_card_status_get,
>>                NULL, "%08llx\n");
>>
>> -#define EXT_CSD_STR_LEN 1025
>> -
>> -static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
>> +static int mmc_ext_csd_read(struct seq_file *s, void *data)
>>  {
>> -       struct mmc_card *card = inode->i_private;
>> -       char *buf;
>> -       ssize_t n = 0;
>> +       struct mmc_card *card = s->private;
>>        u8 *ext_csd;
>> -       int err, i;
>> -
>> -       buf = kmalloc(EXT_CSD_STR_LEN + 1, GFP_KERNEL);
>> -       if (!buf)
>> -               return -ENOMEM;
>> +       u8 ext_csd_rev;
>> +       int err;
>> +       const char *str;
>>
>>        ext_csd = kmalloc(512, GFP_KERNEL);
>>        if (!ext_csd) {
>> @@ -249,41 +243,245 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
>>        if (err)
>>                goto out_free;
>>
>> -       for (i = 511; i >= 0; i--)
>> -               n += sprintf(buf + n, "%02x", ext_csd[i]);
>> -       n += sprintf(buf + n, "\n");
>> -       BUG_ON(n != EXT_CSD_STR_LEN);
>> +       ext_csd_rev = ext_csd[192];
>>
>> -       filp->private_data = buf;
>> -       kfree(ext_csd);
>> -       return 0;
>> +       if (ext_csd_rev > 6)
>> +               goto out_free;
> 
> Isn't the goto in default case of the switch
> below enough?
> 
>> +
>> +       switch (ext_csd_rev) {
>> +       case 6:
>> +               str = "4.5";
>> +               break;
>> +       case 5:
>> +               str = "4.41";
>> +               break;
>> +       case 3:
>> +               str = "4.3";
>> +               break;
>> +       case 2:
>> +               str = "4.2";
>> +               break;
>> +       case 1:
>> +               str = "4.1";
>> +               break;
> 
> case 0:
>     str = "4.0";
>     break;
> 
>> +       default:
>> +               goto out_free;
>> +       }
>> +       seq_printf(s, "Extended CSD rev 1.%d (MMC %s)\n", ext_csd_rev, str);
>> +
>> +       if (ext_csd_rev < 3)
>> +               goto out_free; /* No ext_csd */
>> +
>> +       /* Parse the Extended CSD registers.
>> +        * Reserved bit should be read as "0" in case of spec older
>> +        * than A441.
>> +        */
>> +       seq_printf(s, "s_cmd_set: 0x%02x\n", ext_csd[504]);
>> +       seq_printf(s, "hpi_features: 0x%02x\n", ext_csd[503]);
>> +       seq_printf(s, "blops_support: 0x%02x\n", ext_csd[502]);
> 
> bkops
> 
>> +
>> +       if (ext_csd_rev >= 6) { /* eMMC 4.5 */
>> +               unsigned int cache_size = ext_csd[249] << 0 |
> 
> should this be declared u32?
> 
>> +                                         ext_csd[250] << 8 |
>> +                                         ext_csd[251] << 16 |
>> +                                         ext_csd[252] << 24;
>> +               seq_printf(s, "max_packed_reads: 0x%02x\n", ext_csd[501]);
>> +               seq_printf(s, "max_packed_writes: 0x%02x\n", ext_csd[500]);
>> +               seq_printf(s, "data_tag_support: 0x%02x\n", ext_csd[499]);
>> +               seq_printf(s, "tag_unit_size: 0x%02x\n", ext_csd[498]);
>> +               seq_printf(s, "tag_res_size: 0x%02x\n", ext_csd[497]);
>> +               seq_printf(s, "context_capability: 0x%02x\n", ext_csd[496]);
> 
> capabilities
> 
>> +               seq_printf(s, "large_unit_size_m1: 0x%02x\n", ext_csd[495]);
>> +               seq_printf(s, "ext_support: 0x%02x\n", ext_csd[494]);
>> +               if (cache_size)
>> +                       seq_printf(s, "cache_size[]: %d KiB\n", cache_size);
> 
> why the brackets?
> 
>> +               else
>> +                       seq_printf(s, "No cache existing\n");
> 
> I think "cache_size: 0 KiB\n" be more appropriate. The fact that 0 should
> be interpreted as "no cache exists" should be done by the one/sw reading
> this file. Also just printing the cache_size as given is simpler. Also I think
> you could treat cache_size the same as sec_count below and not declare
> a local variable.
> 
>> +
>> +               seq_printf(s, "generic_cmd6_time: 0x%02x\n", ext_csd[248]);
>> +               seq_printf(s, "power_off_long_time: 0x%02x\n", ext_csd[247]);
>> +       }
>> +
>> +       /* A441: Reserved [501:247]
>> +           A43: reserved [246:229] */
>> +       if (ext_csd_rev >= 5) {
>> +               seq_printf(s, "ini_timeout_ap: 0x%02x\n", ext_csd[241]);
>> +               /* A441: reserved [240] */
>> +               seq_printf(s, "pwr_cl_ddr_52_360 0x%02x\n", ext_csd[239]);
> 
> You lost the colon after the property name starting from this line.
> I sugges you keep it. (I had to read the spec to know that these
> were actually called properities, who knew?)
> 
>> +               seq_printf(s, "pwr_cl_ddr_52_195 0x%02x\n", ext_csd[238]);
>> +
>> +               /* A441: reserved [237-236] */
>> +
>> +               if (ext_csd_rev >= 6) {
>> +                       seq_printf(s, "pwr_cl_200_360 0x%02x\n", ext_csd[237]);
>> +                       seq_printf(s, "pwr_cl_200_195 0x%02x\n", ext_csd[236]);
>> +               }
>> +
>> +               seq_printf(s, "min_perf_ddr_w_8_52 0x%02x\n", ext_csd[235]);
>> +               seq_printf(s, "min_perf_ddr_r_8_52 0x%02x\n", ext_csd[234]);
>> +               /* A441: reserved [233] */
>> +               seq_printf(s, "trim_mult  0x%02x\n", ext_csd[232]);
>> +               seq_printf(s, "sec_feature_support 0x%02x\n", ext_csd[231]);
>> +       }
>> +       if (ext_csd_rev == 5) { /* Obsolete in 4.5 */
>> +               seq_printf(s, "sec_erase_mult 0x%02x\n", ext_csd[230]);
>> +               seq_printf(s, "sec_trim_mult  0x%02x\n", ext_csd[229]);
>> +       }
>> +       seq_printf(s, "boot_info 0x%02x\n", ext_csd[228]);
>> +       /* A441/A43: reserved [227] */
>> +       seq_printf(s, "boot_size_multi 0x%02x\n", ext_csd[226]);
>> +       seq_printf(s, "acc_size 0x%02x\n", ext_csd[225]);
>> +       seq_printf(s, "hc_erase_grp_size 0x%02x\n", ext_csd[224]);
>> +       seq_printf(s, "erase_timeout_mult 0x%02x\n", ext_csd[223]);
>> +       seq_printf(s, "rel_wr_sec_c 0x%02x\n", ext_csd[222]);
>> +       seq_printf(s, "hc_wp_grp_size 0x%02x\n", ext_csd[221]);
>> +       seq_printf(s, "s_c_vcc 0x%02x\n", ext_csd[220]);
>> +       seq_printf(s, "s_c_vccq 0x%02x\n", ext_csd[219]);
>> +       /* A441/A43: reserved [218] */
>> +       seq_printf(s, "s_a_timeout 0x%02x\n", ext_csd[217]);
>> +       /* A441/A43: reserved [216] */
>> +       seq_printf(s, "sec_count 0x%02x\n", (ext_csd[215] << 24) |
> 
> 0x%08x or %d would be better I believe.
> 
>> +                     (ext_csd[214] << 16) | (ext_csd[213] << 8)  |
>> +                     ext_csd[212]);
>> +       /* A441/A43: reserved [211] */
>> +       seq_printf(s, "min_perf_w_8_52 0x%02x\n", ext_csd[210]);
>> +       seq_printf(s, "min_perf_r_8_52 0x%02x\n", ext_csd[209]);
>> +       seq_printf(s, "min_perf_w_8_26_4_52 0x%02x\n", ext_csd[208]);
>> +       seq_printf(s, "min_perf_r_8_26_4_52 0x%02x\n", ext_csd[207]);
>> +       seq_printf(s, "min_perf_w_4_26 0x%02x\n", ext_csd[206]);
>> +       seq_printf(s, "min_perf_r_4_26 0x%02x\n", ext_csd[205]);
>> +       /* A441/A43: reserved [204] */
>> +       seq_printf(s, "pwr_cl_26_360 0x%02x\n", ext_csd[203]);
>> +       seq_printf(s, "pwr_cl_52_360 0x%02x\n", ext_csd[202]);
>> +       seq_printf(s, "pwr_cl_26_195 0x%02x\n", ext_csd[201]);
>> +       seq_printf(s, "pwr_cl_52_195 0x%02x\n", ext_csd[200]);
>> +
>> +       /* A43: reserved [199:198] */
>> +       if (ext_csd_rev >= 5) {
>> +               seq_printf(s, "partition_switch_time  0x%02x\n", ext_csd[199]);
>> +               seq_printf(s, "out_of_interrupt_time  0x%02x\n", ext_csd[198]);
>> +       }
>> +
>> +       /* A441/A43: reserved   [197] [195] [193] [190] [188]
>> +        * [186] [184] [182] [180] [176] */
>> +
>> +       if (ext_csd_rev >= 6)
>> +               seq_printf(s, "driver_strength 0x%02x\n", ext_csd[197]);
>> +
>> +       seq_printf(s, "card_type  0x%02x\n", ext_csd[196]);
>> +       seq_printf(s, "csd_structure 0x%02x\n", ext_csd[194]);
>> +       seq_printf(s, "ext_csd_rev 0x%02x\n", ext_csd[192]);
>> +       seq_printf(s, "cmd_set 0x%02x\n", ext_csd[191]);
>> +       seq_printf(s, "cmd_set_rev 0x%02x\n", ext_csd[189]);
>> +       seq_printf(s, "power_class 0x%02x\n", ext_csd[187]);
>> +       seq_printf(s, "hs_timing 0x%02x\n", ext_csd[185]);
>> +       seq_printf(s, "bus_width 0x%02x\n", ext_csd[183]);
> 
> hm.. spec 4.5 defines this as not readable. I wonder it it makes
> sense to print it? I guess that any card would transfer 0 or some
> other constant value in this property...
> 
>> +       seq_printf(s, "erased_mem_cont 0x%02x\n", ext_csd[181]);
>> +       seq_printf(s, "partition_config 0x%02x\n", ext_csd[179]);
>> +       seq_printf(s, "boot_config_prot 0x%02x\n", ext_csd[178]);
>> +       seq_printf(s, "boot_bus_width 0x%02x\n", ext_csd[177]);
> 
> boot_bus_conditions according to spec 4.5...
> 
>> +       seq_printf(s, "erase_group_def 0x%02x\n", ext_csd[175]);
>> +
>> +       /* A43: reserved [174:0] / A441: reserved [174] */
> 
> maybe, but spec 4.5 seems to define (though I admit that the line
> in the table is curiously grayed out, maybe it's a typo in the spec
> since 174 used to be reserved in 4.41...):
> 
> seq_printf(s, "boot_wp_status 0x%02x\n", ext_csd[174]);
> 
>> +       if (ext_csd_rev >= 5) {
>> +               seq_printf(s, "boot_wp 0x%02x\n", ext_csd[173]);
>> +               /* A441: reserved [172] */
>> +               seq_printf(s, "user_wp 0x%02x\n", ext_csd[171]);
>> +               /* A441: reserved [170] */
>> +               seq_printf(s, "fw_config 0x%02x\n", ext_csd[169]);
>> +               seq_printf(s, "rpmb_size_mult 0x%02x\n", ext_csd[168]);
>> +               seq_printf(s, "wr_rel_set 0x%02x\n", ext_csd[167]);
>> +               seq_printf(s, "wr_rel_param 0x%02x\n", ext_csd[166]);
>> +               /* A441: reserved [165] */
> 
> spec 4.5 seems to define sanitize_start here, but as for bus_width
> above, it is not really readable. I don't know whether you should
> include it or not. it may just be confusing. but either way the comment
> should be updated to reflect that 4.5 does indeed have a property here.
> 
> seq_printf(s, "sanitize_start: 0x%02x\n", ext_csd[165]);
> 
>> +               seq_printf(s, "bkops_start 0x%02x\n", ext_csd[164]);
> 
> this is only writeable, same as for bus_width...
> 
>> +               seq_printf(s, "bkops_en 0x%02x\n", ext_csd[163]);
>> +               seq_printf(s, "rst_n_function 0x%02x\n", ext_csd[162]);
>> +               seq_printf(s, "hpi_mgmt 0x%02x\n", ext_csd[161]);
>> +               seq_printf(s, "partitioning_support 0x%02x\n", ext_csd[160]);
>> +               seq_printf(s, "max_enh_size_mult[2] 0x%02x\n", ext_csd[159]);
>> +               seq_printf(s, "max_enh_size_mult[1] 0x%02x\n", ext_csd[158]);
>> +               seq_printf(s, "max_enh_size_mult[0] 0x%02x\n", ext_csd[157]);
> 
> seq_printf(s, "max_enh_size_mult: 0x%06x\n", (ext_csd[159] << 16) |
>     (ext_csd[158] << 8) | ext_csd[157]);
> 
> this seems more to fit with your handling of sec_count above.
> 
>> +               seq_printf(s, "partitions_attribute 0x%02x\n", ext_csd[156]);
>> +               seq_printf(s, "partition_setting_completed 0x%02x\n",
>> +                             ext_csd[155]);
>> +               seq_printf(s, "gp_size_mult_4[2] 0x%02x\n", ext_csd[154]);
>> +               seq_printf(s, "gp_size_mult_4[1] 0x%02x\n", ext_csd[153]);
>> +               seq_printf(s, "gp_size_mult_4[0] 0x%02x\n", ext_csd[152]);
>> +               seq_printf(s, "gp_size_mult_3[2] 0x%02x\n", ext_csd[151]);
>> +               seq_printf(s, "gp_size_mult_3[1] 0x%02x\n", ext_csd[150]);
>> +               seq_printf(s, "gp_size_mult_3[0] 0x%02x\n", ext_csd[149]);
>> +               seq_printf(s, "gp_size_mult_2[2] 0x%02x\n", ext_csd[148]);
>> +               seq_printf(s, "gp_size_mult_2[1] 0x%02x\n", ext_csd[147]);
>> +               seq_printf(s, "gp_size_mult_2[0] 0x%02x\n", ext_csd[146]);
>> +               seq_printf(s, "gp_size_mult_1[2] 0x%02x\n", ext_csd[145]);
>> +               seq_printf(s, "gp_size_mult_1[1] 0x%02x\n", ext_csd[144]);
>> +               seq_printf(s, "gp_size_mult_1[0] 0x%02x\n", ext_csd[143]);
>> +               seq_printf(s, "enh_size_mult[2] 0x%02x\n", ext_csd[142]);
>> +               seq_printf(s, "enh_size_mult[1] 0x%02x\n", ext_csd[141]);
>> +               seq_printf(s, "enh_size_mult[0] 0x%02x\n", ext_csd[140]);
>> +               seq_printf(s, "enh_start_addr[3] 0x%02x\n", ext_csd[139]);
>> +               seq_printf(s, "enh_start_addr[2] 0x%02x\n", ext_csd[138]);
>> +               seq_printf(s, "enh_start_addr[1] 0x%02x\n", ext_csd[137]);
>> +               seq_printf(s, "enh_start_addr[0] 0x%02x\n", ext_csd[136]);
> 
> seq_printf(s, "gp_size_mult_4: 0x%06x\n", (ext_csd[154] << 16) |
> (ext_csd[153] << 8) | ext_csd[152]);
> seq_printf(s, "gp_size_mult_3: 0x%06x\n", (ext_csd[151] << 16) |
> (ext_csd[150] << 8) | ext_csd[149]);
> seq_printf(s, "gp_size_mult_2: 0x%06x\n", (ext_csd[148] << 16) |
> (ext_csd[147] << 8) | ext_csd[146]);
> seq_printf(s, "gp_size_mult_1: 0x%06x\n", (ext_csd[145] << 16) |
> (ext_csd[144] << 8) | ext_csd[143]);
> seq_printf(s, "enh_size_mult: 0x%06x\n", (ext_csd[142] << 16) |
> (ext_csd[141] << 8) | ext_csd[140]);
> seq_printf(s, "enh_start_addr: 0x%06x\n", (ext_csd[139] << 16) |
> (ext_csd[138] << 8) | ext_csd[137]);
> 
> same comment as for max_enh_size_mult...
> 
>> +               /* A441: reserved [135] */
>> +               seq_printf(s, "sec_bad_blk_mgmnt 0x%02x\n", ext_csd[134]);
>> +               /* A441: reserved [133:0] */
>> +       }
>> +       /* B45 */
>> +       if (ext_csd_rev >= 6) {
>> +               int j;
>> +               seq_printf(s, "tcase_support 0x%02x\n", ext_csd[132]);
> 
> not readable according to spec 4.5...
> also spec 4.5 defines which you may want to include:
> 
> seq_printf(s, "periodic_wakeup: 0x%02x\n", ext_csd[131]);
> 
>> +               seq_printf(s, "program_cid_csd_ddr_support 0x%02x\n",
>> +                          ext_csd[130]);
>> +
>> +               seq_printf(s, "vendor_specific_field:\n");
>> +               for (j = 127; j >= 64; j--)
>> +                       seq_printf(s, "\t[%d] 0x%02x\n", j, ext_csd[j]);
> 
> printing an array here make sense (since it _is_ really a byte array),
> but what about replacing the last three lines with:
> 
> for (j = 127; j >= 64; j--)
>     seq_printf(s, "vendor_specific_field[%d]: 0x%02x\n", j, ext_csd[j]);
> 
> that way all lines in the sysfs-file follow the same format without indentation.
> 
>> +
>> +               seq_printf(s, "native_sector_size 0x%02x\n", ext_csd[63]);
>> +               seq_printf(s, "use_native_sector 0x%02x\n", ext_csd[62]);
>> +               seq_printf(s, "data_sector_size 0x%02x\n", ext_csd[61]);
>> +               seq_printf(s, "ini_timeout_emu 0x%02x\n", ext_csd[60]);
>> +               seq_printf(s, "class_6_ctrl 0x%02x\n", ext_csd[59]);
>> +               seq_printf(s, "dyncap_needed 0x%02x\n", ext_csd[58]);
>> +               seq_printf(s, "exception_events_ctrl[1] 0x%02x\n", ext_csd[57]);
>> +               seq_printf(s, "exception_events_ctrl[0] 0x%02x\n", ext_csd[56]);
>> +               seq_printf(s, "exception_events_status[1] 0x%02x\n",
>> +                          ext_csd[55]);
>> +               seq_printf(s, "exception_events_status[0] 0x%02x\n",
>> +                          ext_csd[54]);
>> +               seq_printf(s, "ext_partition_attribute[1] 0x%02x\n",
>> +                          ext_csd[53]);
>> +               seq_printf(s, "ext_partition_attribute[0] 0x%02x\n",
>> +                          ext_csd[52]);
> 
> 
> seq_printf(s, "exception_events_ctrl: 0x%04x\n", (ext_csd[57] << 8) |
> ext_csd[56]);
> seq_printf(s, "exception_events_status: 0x%04x\n", (ext_csd[55] << 8)
> | ext_csd[54]);
> seq_printf(s, "ext_partitions_attribute: 0x%04x\n", (ext_csd[53] << 8)
> | ext_csd[52]);
> 
> notice the s in partitions...
> 
>> +
>> +               seq_printf(s, "context_conf:\n");
>> +               for (j = 51; j >= 37; j--)
>> +                       seq_printf(s, "\t[%d] 0x%02x\n", j, ext_csd[j]);
> 
> same as for vendor_specific_field above, I would suggest doing
> 
> for (j = 51; j >= 37; j--)
>     seq_printf(s, "context_conf[%d]: 0x%02x\n", j, ext_csd[j]);
> 
>> +
>> +               seq_printf(s, "packed_command_status 0x%02x\n", ext_csd[36]);
>> +               seq_printf(s, "packed_failure_index 0x%02x\n", ext_csd[35]);
>> +               seq_printf(s, "power_off_notification 0x%02x\n", ext_csd[34]);
>> +               seq_printf(s, "cache_ctrl 0x%02x\n", ext_csd[33]);
>> +               seq_printf(s, "flush_cache 0x%02x\n", ext_csd[32]);
> 
> this property is not readable.
> 
>> +               /*Reserved [31:0] */
>> +       }
>>
>>  out_free:
>> -       kfree(buf);
>>        kfree(ext_csd);
>>        return err;
>>  }
>>
>> -static ssize_t mmc_ext_csd_read(struct file *filp, char __user *ubuf,
>> -                               size_t cnt, loff_t *ppos)
>> +static int mmc_ext_csd_open(struct inode *inode, struct file *file)
>>  {
>> -       char *buf = filp->private_data;
>> -
>> -       return simple_read_from_buffer(ubuf, cnt, ppos,
>> -                                      buf, EXT_CSD_STR_LEN);
>> -}
>> -
>> -static int mmc_ext_csd_release(struct inode *inode, struct file *file)
>> -{
>> -       kfree(file->private_data);
>> -       return 0;
>> +       return single_open(file, mmc_ext_csd_read, inode->i_private);
>>  }
>>
>>  static const struct file_operations mmc_dbg_ext_csd_fops = {
>>        .open           = mmc_ext_csd_open,
>> -       .read           = mmc_ext_csd_read,
>> -       .release        = mmc_ext_csd_release,
>> -       .llseek         = default_llseek,
>> +       .read           = seq_read,
>> +       .llseek         = seq_lseek,
>> +       .release        = single_release,
>>  };
>>
>>  void mmc_add_card_debugfs(struct mmc_card *card)
>> --
>> 1.7.4.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
>  / Sebastian
> 

