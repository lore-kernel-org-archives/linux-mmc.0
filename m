From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v7 3/4] gpiolib: Pass array info to get/set array functions
Date: Tue, 4 Sep 2018 23:23:40 +0800
Message-ID: <20180904152340.GT17047@intel.com>
References: <20180902120144.6855-4-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6zn93sY2JrH9m7VZ"
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20180902120144.6855-4-jmkrzyszt@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, linux-doc@vger.kernel.org, linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Peter Rosin <peda@axentia.se>, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devel@driverdev.osuosl.org, Florian Fainelli <f.fainelli@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Lukas Wunner <lukas@wunner.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Michael Hennerich <Michael.Hennerich@analog.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: linux-mmc@vger.kernel.org


--6zn93sY2JrH9m7VZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Janusz,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on gpio/for-next]
[also build test WARNING on v4.19-rc2 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Janusz-Krzysztofik/gpiolib-Pass-bitmaps-not-integer-arrays-to-get-set-array/20180903-172834
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-next
reproduce: make htmldocs
:::::: branch date: 8 hours ago
:::::: commit date: 8 hours ago

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/srcu.h:175: warning: Function parameter or member 'p' not described in 'srcu_dereference_notrace'
   include/linux/srcu.h:175: warning: Function parameter or member 'sp' not described in 'srcu_dereference_notrace'
   include/linux/gfp.h:1: warning: no structured comments found
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
   include/net/mac80211.h:2328: warning: Function parameter or member 'radiotap_timestamp.units_pos' not described in 'ieee80211_hw'
   include/net/mac80211.h:2328: warning: Function parameter or member 'radiotap_timestamp.accuracy' not described in 'ieee80211_hw'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.rts_cts_rate_idx' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.use_rts' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.use_cts_prot' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.short_preamble' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.skip_table' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.jiffies' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.vif' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.hw_key' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.flags' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.enqueue_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'ack' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'ack.cookie' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.ampdu_ack_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.ampdu_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.antenna' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.tx_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.is_valid_ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.status_driver_data' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'driver_rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'pad' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'rate_driver_data' not described in 'ieee80211_tx_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'rx_stats_avg' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'rx_stats_avg.signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'rx_stats_avg.chain_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.filtered' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.retry_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.retry_count' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.lost_packets' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.last_tdls_pkt_time' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.msdu_retries' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.msdu_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.last_ack' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.last_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.ack_signal_filled' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.avg_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.packets' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.bytes' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.last_rate' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.msdu' not described in 'sta_info'
   include/linux/mod_devicetable.h:763: warning: Function parameter or member 'driver_data' not described in 'typec_device_id'
   kernel/sched/fair.c:3371: warning: Function parameter or member 'flags' not described in 'attach_entity_load_avg'
   arch/x86/include/asm/atomic.h:84: warning: Excess function parameter 'i' description in 'arch_atomic_sub_and_test'
   arch/x86/include/asm/atomic.h:84: warning: Excess function parameter 'v' description in 'arch_atomic_sub_and_test'
   arch/x86/include/asm/atomic.h:96: warning: Excess function parameter 'v' description in 'arch_atomic_inc'
   arch/x86/include/asm/atomic.h:109: warning: Excess function parameter 'v' description in 'arch_atomic_dec'
   arch/x86/include/asm/atomic.h:124: warning: Excess function parameter 'v' description in 'arch_atomic_dec_and_test'
   arch/x86/include/asm/atomic.h:138: warning: Excess function parameter 'v' description in 'arch_atomic_inc_and_test'
   arch/x86/include/asm/atomic.h:153: warning: Excess function parameter 'i' description in 'arch_atomic_add_negative'
   arch/x86/include/asm/atomic.h:153: warning: Excess function parameter 'v' description in 'arch_atomic_add_negative'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.active' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.active' not described in 'dma_buf'
   include/linux/dma-fence-array.h:54: warning: Function parameter or member 'work' not described in 'dma_fence_array'
   include/linux/gpio/driver.h:142: warning: Function parameter or member 'request_key' not described in 'gpio_irq_chip'
>> drivers/gpio/gpiolib.c:2917: warning: Function parameter or member 'array_info' not described in 'gpiod_get_raw_array_value'
>> drivers/gpio/gpiolib.c:2942: warning: Function parameter or member 'array_info' not described in 'gpiod_get_array_value'
   drivers/gpio/gpiolib.c:2942: warning: Function parameter or member 'value_bitmap' not described in 'gpiod_get_array_value'
   drivers/gpio/gpiolib.c:2942: warning: Excess function parameter 'value_bitnap' description in 'gpiod_get_array_value'
>> drivers/gpio/gpiolib.c:3180: warning: Function parameter or member 'array_info' not described in 'gpiod_set_raw_array_value'
>> drivers/gpio/gpiolib.c:3204: warning: Function parameter or member 'array_info' not described in 'gpiod_set_array_value'
>> drivers/gpio/gpiolib.c:3442: warning: Function parameter or member 'array_info' not described in 'gpiod_get_raw_array_value_cansleep'
>> drivers/gpio/gpiolib.c:3467: warning: Function parameter or member 'array_info' not described in 'gpiod_get_array_value_cansleep'
>> drivers/gpio/gpiolib.c:3528: warning: Function parameter or member 'array_info' not described in 'gpiod_set_raw_array_value_cansleep'
>> drivers/gpio/gpiolib.c:3569: warning: Function parameter or member 'array_info' not described in 'gpiod_set_array_value_cansleep'
   include/linux/iio/hw-consumer.h:1: warning: no structured comments found
   include/linux/input/sparse-keymap.h:46: warning: Function parameter or member 'sw' not described in 'key_entry'
   drivers/pci/pci.c:218: warning: Excess function parameter 'p' description in 'pci_dev_str_match_path'
   include/linux/regulator/driver.h:227: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   drivers/regulator/core.c:4479: warning: Excess function parameter 'state' description in 'regulator_suspend'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw0' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw1' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw2' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw3' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.eadm' not described in 'irb'
   drivers/slimbus/stream.c:1: warning: no structured comments found
   drivers/target/target_core_device.c:1: warning: no structured comments found
   drivers/usb/dwc3/gadget.c:510: warning: Excess function parameter 'dwc' description in 'dwc3_gadget_start_config'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/bus.c:1: warning: no structured comments found
   drivers/usb/typec/bus.c:268: warning: Function parameter or member 'mode' not described in 'typec_match_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1: warning: no structured comments found
   include/linux/w1.h:281: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
   fs/direct-io.c:257: warning: Excess function parameter 'offset' description in 'dio_complete'
   fs/file_table.c:1: warning: no structured comments found
   fs/libfs.c:477: warning: Excess function parameter 'available' description in 'simple_write_end'
   fs/posix_acl.c:646: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:646: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:646: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:183: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_read_lock'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:254: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_invalidate_range_start_gfx'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:302: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2986: warning: Excess function parameter 'dev' description in 'amdgpu_vm_get_task_info'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2987: warning: Function parameter or member 'adev' not described in 'amdgpu_vm_get_task_info'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2987: warning: Excess function parameter 'dev' description in 'amdgpu_vm_get_task_info'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   include/drm/drm_panel.h:98: warning: Function parameter or member 'link' not described in 'drm_panel'
   drivers/gpu/drm/i915/i915_vma.h:49: warning: cannot understand function prototype: 'struct i915_vma '
   drivers/gpu/drm/i915/i915_vma.h:1: warning: no structured comments found
   drivers/gpu/drm/i915/intel_guc_fwif.h:553: warning: cannot understand function prototype: 'struct guc_log_buffer_state '
   drivers/gpu/drm/i915/i915_trace.h:1: warning: no structured comments found
   include/linux/skbuff.h:860: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'list' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'skb_mstamp' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'offload_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'offload_mr_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:238: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
   include/net/sock.h:509: warning: Function parameter or member 'sk_backlog.rmem_alloc' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'sk_backlog.len' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'sk_backlog.head' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'sk_backlog.tail' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'adj_list.upper' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'adj_list.lower' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'switchdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'

# https://github.com/0day-ci/linux/commit/dea6937cb6f545e86b0d5bc4c7e31be802de175d
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout dea6937cb6f545e86b0d5bc4c7e31be802de175d
vim +2917 drivers/gpio/gpiolib.c

d2876d08 David Brownell     2008-02-04  2898  
eec1d566 Lukas Wunner       2017-10-12  2899  /**
eec1d566 Lukas Wunner       2017-10-12  2900   * gpiod_get_raw_array_value() - read raw values from an array of GPIOs
916010a7 Janusz Krzysztofik 2018-09-02  2901   * @array_size: number of elements in the descriptor array / value bitmap
eec1d566 Lukas Wunner       2017-10-12  2902   * @desc_array: array of GPIO descriptors whose values will be read
916010a7 Janusz Krzysztofik 2018-09-02  2903   * @value_bitmap: bitmap to store the read values
eec1d566 Lukas Wunner       2017-10-12  2904   *
eec1d566 Lukas Wunner       2017-10-12  2905   * Read the raw values of the GPIOs, i.e. the values of the physical lines
eec1d566 Lukas Wunner       2017-10-12  2906   * without regard for their ACTIVE_LOW status.  Return 0 in case of success,
eec1d566 Lukas Wunner       2017-10-12  2907   * else an error code.
eec1d566 Lukas Wunner       2017-10-12  2908   *
eec1d566 Lukas Wunner       2017-10-12  2909   * This function should be called from contexts where we cannot sleep,
eec1d566 Lukas Wunner       2017-10-12  2910   * and it will complain if the GPIO chip functions potentially sleep.
eec1d566 Lukas Wunner       2017-10-12  2911   */
eec1d566 Lukas Wunner       2017-10-12  2912  int gpiod_get_raw_array_value(unsigned int array_size,
916010a7 Janusz Krzysztofik 2018-09-02  2913  			      struct gpio_desc **desc_array,
dea6937c Janusz Krzysztofik 2018-09-02  2914  			      struct gpio_array *array_info,
916010a7 Janusz Krzysztofik 2018-09-02  2915  			      unsigned long *value_bitmap)
eec1d566 Lukas Wunner       2017-10-12  2916  {
eec1d566 Lukas Wunner       2017-10-12 @2917  	if (!desc_array)
eec1d566 Lukas Wunner       2017-10-12  2918  		return -EINVAL;
eec1d566 Lukas Wunner       2017-10-12  2919  	return gpiod_get_array_value_complex(true, false, array_size,
dea6937c Janusz Krzysztofik 2018-09-02  2920  					     desc_array, array_info,
dea6937c Janusz Krzysztofik 2018-09-02  2921  					     value_bitmap);
eec1d566 Lukas Wunner       2017-10-12  2922  }
eec1d566 Lukas Wunner       2017-10-12  2923  EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value);
eec1d566 Lukas Wunner       2017-10-12  2924  
eec1d566 Lukas Wunner       2017-10-12  2925  /**
eec1d566 Lukas Wunner       2017-10-12  2926   * gpiod_get_array_value() - read values from an array of GPIOs
916010a7 Janusz Krzysztofik 2018-09-02  2927   * @array_size: number of elements in the descriptor array / value bitmap
eec1d566 Lukas Wunner       2017-10-12  2928   * @desc_array: array of GPIO descriptors whose values will be read
916010a7 Janusz Krzysztofik 2018-09-02  2929   * @value_bitnap: bitmap to store the read values
eec1d566 Lukas Wunner       2017-10-12  2930   *
eec1d566 Lukas Wunner       2017-10-12  2931   * Read the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
eec1d566 Lukas Wunner       2017-10-12  2932   * into account.  Return 0 in case of success, else an error code.
eec1d566 Lukas Wunner       2017-10-12  2933   *
eec1d566 Lukas Wunner       2017-10-12  2934   * This function should be called from contexts where we cannot sleep,
eec1d566 Lukas Wunner       2017-10-12  2935   * and it will complain if the GPIO chip functions potentially sleep.
eec1d566 Lukas Wunner       2017-10-12  2936   */
eec1d566 Lukas Wunner       2017-10-12  2937  int gpiod_get_array_value(unsigned int array_size,
916010a7 Janusz Krzysztofik 2018-09-02  2938  			  struct gpio_desc **desc_array,
dea6937c Janusz Krzysztofik 2018-09-02  2939  			  struct gpio_array *array_info,
916010a7 Janusz Krzysztofik 2018-09-02  2940  			  unsigned long *value_bitmap)
eec1d566 Lukas Wunner       2017-10-12  2941  {
eec1d566 Lukas Wunner       2017-10-12 @2942  	if (!desc_array)
eec1d566 Lukas Wunner       2017-10-12  2943  		return -EINVAL;
eec1d566 Lukas Wunner       2017-10-12  2944  	return gpiod_get_array_value_complex(false, false, array_size,
dea6937c Janusz Krzysztofik 2018-09-02  2945  					     desc_array, array_info,
dea6937c Janusz Krzysztofik 2018-09-02  2946  					     value_bitmap);
eec1d566 Lukas Wunner       2017-10-12  2947  }
eec1d566 Lukas Wunner       2017-10-12  2948  EXPORT_SYMBOL_GPL(gpiod_get_array_value);
eec1d566 Lukas Wunner       2017-10-12  2949  

:::::: The code at line 2917 was first introduced by commit
:::::: eec1d566cdf94b57e8f5ba9fe60eea214929bcfc gpio: Introduce ->get_multiple callback

:::::: TO: Lukas Wunner <lukas@wunner.de>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--6zn93sY2JrH9m7VZ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6zn93sY2JrH9m7VZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--6zn93sY2JrH9m7VZ--
